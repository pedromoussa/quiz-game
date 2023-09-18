document.addEventListener('DOMContentLoaded', function () {
  const rangeInputs = document.querySelectorAll('.range-filter-input');

  rangeInputs.forEach(function (input) {
    input.addEventListener('blur', function () {
      const minMax = this.value.split('-').map((val) => val.trim());
      const paramName = this.getAttribute('name');
      const filterForm = this.closest('form');

      // Set the filter parameters based on min and max values
      if (minMax.length === 2) {
        filterForm.querySelector(`input[name="${paramName}_gteq"]`).value = minMax[0];
        filterForm.querySelector(`input[name="${paramName}_lteq"]`).value = minMax[1];
      } else {
        // Clear filter if invalid input
        filterForm.querySelector(`input[name="${paramName}_gteq"]`).value = '';
        filterForm.querySelector(`input[name="${paramName}_lteq"]`).value = '';
      }
    });
  });
});