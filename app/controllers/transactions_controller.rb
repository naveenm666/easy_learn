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
        render json: { success: true, redirect_url: students_path }
      else
        render json: { success: false }, status: :unprocessable_entity
      end
    rescue => e
      render json: { success: false, error: e.message }, status: :unprocessable_entity
    end
  end
end
