

// this is temporary JS for the white label landing page
$(document).on('change', '#white-label-landing-select-state', function() {
  if ($(this).val() == 'choose') {
    $('.form-item-white-label-organization').addClass("disabled");
    $('.form-item-white-label-organization select').prop('disabled', true);
  } else {
    $('.form-item-white-label-organization').removeClass("disabled");
    $('.form-item-white-label-organization select').removeAttr("disabled");
  }
});

$(document).on('change', '#white-label-landing-select-organization', function() {
  if ($(this).val() == 'choose') {
    $('.form-item-white-label-submit').addClass("disabled");
  } else {
    $('.form-item-white-label-submit').removeClass("disabled");
  }
});

// when the program highlights on the white label homepage is in a carousel
// we can't use flexbox for equal heights - so this is a javascript solution
$(function() {
  $('.program-highlights-carousel-container .program-highlight__text').matchHeight();
});



//Set counter for Image slider
// $('.currItem').html("1");
// $('.currTotal').html($('.ncoa-carousel-container .item').length);

$('.program-highlights-carousel-container').slick({
  autoplay: false,
  autoplaySpeed: 5000,
  dots: false,
  infinite: true,
  speed: 1000,
  slidesToShow: 3,
  slidesToScroll: 1,
  nextArrow: '<span class="fa fa-chevron-right" aria-hidden="true"></span>',
  prevArrow: '<span class="fa fa-chevron-left" aria-hidden="true"></span>',
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 1,
        dots: false,
        appendArrows: $('.program-highlights-carousel-container')
      }
    },
    {
      breakpoint: 1000,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 1,
        appendArrows: $('.program-highlights-carousel-container')
      }
    },
    {
      breakpoint: 768,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        appendArrows: $('.program-highlights-carousel-container')
      }
    }
  ]
});

// $('.program-highlights-carousel').on('afterChange', function(event, slick, currentSlide, nextSlide){
//     $('.currItem').html(currentSlide + 1);
// });

