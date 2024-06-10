
  document.addEventListener('DOMContentLoaded', function() {
    const freeOrPaidSelect = document.getElementById('course_free_or_paid');
    const priceField = document.getElementById('price-field');

    function togglePriceField() {
      priceField.style.display = freeOrPaidSelect.value === 'paid' ? 'block' : 'none';
    }

  
    togglePriceField();

    
    freeOrPaidSelect.addEventListener('change', togglePriceField);
  });
