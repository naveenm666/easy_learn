class TransactionsController < ApplicationController
  require 'razorpay'

  def index
    @transactions = current_student.transactions.includes(:course)
  end

  def verify_payment
    payment_response = JSON.parse(request.raw_post)
  
    secret = Rails.application.credentials.dig(:razorpay, :secret_key)

    orderId = payment_response["orderId"] 
    paymentId = payment_response["paymentId"]  
    signature = payment_response["signature"]
  
    begin
      expected_signature = Razorpay::Utility.verify_payment_signature(
        razorpay_order_id: orderId,
        razorpay_payment_id: paymentId,
        razorpay_signature: signature,
      )

      if expected_signature
        # Find the transaction associated with this order
        transaction = current_student.transactions.find_by(order_id: orderId)
        
        if transaction
          transaction.update(payment_id: paymentId, status: 'success')
          CoursePurchaseNotificationJob.perform_later(current_student, transaction.course)
          CourseExpirationNotificationJob.set(wait_until: transaction.created_at + 4.minutes).perform_later(current_student, transaction.course)
          render json: { success: true, redirect_url: students_path }
          return
        else
          render json: { success: false, error: 'Transaction not found for this order.' }, status: :unprocessable_entity
          return
        end
      else
        render json: { success: false }, status: :unprocessable_entity
        return
      end
    rescue => e
      render json: { success: false, error: e.message }, status: :unprocessable_entity
      return
    end
  end
end
