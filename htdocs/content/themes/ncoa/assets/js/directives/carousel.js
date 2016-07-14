app.directive('ncoaCarousel', [function(){
	return {		
		link: function(scope, elm){

			
			//Set counter for Image slider
			$('.currItem').html("1");
			$('.currTotal').html($('.ncoa-carousel-container .item').length);
			

			$(elm).slick({
				autoplay: true,
				autoplaySpeed: 5000,
			  	dots: false,
			  	infinite: true,
			  	speed: 1000,
			  	slidesToShow: 3,
			  	slidesToScroll: 3,
			  	nextArrow: '<span class="fa fa-chevron-right" aria-hidden="true"></span>',
			  	prevArrow: '<span class="fa fa-chevron-left" aria-hidden="true"></span>',
			  	responsive: [
			    {
			      breakpoint: 1024,
			      settings: {
			        slidesToShow: 3,
			        slidesToScroll: 3,
			        infinite: false,
			        dots: false,
			        appendArrows: $(elm)
			      }
			    },
			    {
			      breakpoint: 1000,
			      settings: {
			        slidesToShow: 2,
			        slidesToScroll: 2,
			        appendArrows: $('.controls')
			      }
			    },
			    {
			      breakpoint: 480,
			      settings: {
			        slidesToShow: 1,
			        slidesToScroll: 1,
			        appendArrows: $('.controls')
			      }
			    }
			    // You can unslick at a given breakpoint now by adding:
			    // settings: "unslick"
			    // instead of a settings object
			  ]
			});

			$(elm).on('afterChange', function(event, slick, currentSlide, nextSlide){
		  		$('.currItem').html(currentSlide + 1);
			});
		}
	}
}]);