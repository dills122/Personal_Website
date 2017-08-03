//Check if Mobile Function
var isMobile = {
	Android: function() {
		return navigator.userAgent.match(/Android/i);
	},
	BlackBerry: function() {
		return navigator.userAgent.match(/BlackBerry/i);
	},
	iOS: function() {
		return navigator.userAgent.match(/iPhone|iPad|iPod/i);
	},
	Opera: function() {
		return navigator.userAgent.match(/Opera Mini/i);
	},
	Windows: function() {
		return navigator.userAgent.match(/IEMobile/i);
	},
	any: function() {
		return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
	}
};

$(window).ready(function() {
	if(isMobile.any()) {
//Centers Social Icons
$('.social-container').css("text-align","center");

$('#title-page').removeClass("row-column").addClass("row-column-mobile");
$('#about-page').removeClass("row").addClass("row-mobile");
$('.title-container span').removeClass("title-text").addClass("title-text-mobile");
$('#description-col').removeClass("column").addClass("column-mobile");
$('#accordian-col').removeClass("column").addClass("column-mobile");
$('#footer-page').removeClass("half-row").addClass("half-row-mobile");
$('#contact-col').removeClass("column-half").addClass("column-half-mobile");
$('#footer-col').removeClass("column-half").addClass("column-half-mobile");
$('.link-container').addClass("link-container-mobile").removeClass("link-container");
$('.link-cell').addClass("link-cell-mobile").removeClass("link-cell");
} else 
{
	var viewWidth = $(window).width();
	if (viewWidth <1110) {
		$('#description-col').removeClass("column").addClass("column-small");
		$('#accordian-col').removeClass("column").addClass("column-small");
		$('#footer-col').removeClass("column").addClass("column-half-small");
		$('#contact-col').removeClass("column").addClass("column-half-small");
		$('#about-page').removeClass("row").addClass("row-small");
		$('#footer-page').removeClass("half-row").addClass("half-row-small");
	}
}
});

$(window).on('ready, resize', function() {
	var viewWidth = $(window).width();
	if (viewWidth < 1100) {
		$('#description-col').removeClass("column").addClass("column-small");
		$('#accordian-col').removeClass("column").addClass("column-small");
		$('#footer-col').removeClass("column-half").addClass("column-half-small");
		$('#contact-col').removeClass("column-half").addClass("column-half-small");
		$('#about-page').removeClass("row").addClass("row-small");
		$('#footer-page').removeClass("half-row").addClass("half-row-small");
	}
	else {
		$('#description-col').removeClass("column-small").addClass("column");
		$('#accordian-col').removeClass("column-small").addClass("column");
		$('#footer-col').removeClass("column-half-small").addClass("column-half");
		$('#contact-col').removeClass("column-half-small").addClass("column-half");
		$('#about-page').removeClass("row-small").addClass("row");
		$('#footer-page').removeClass("half-row-small").addClass("half-row");
	}
});


jQuery(document).ready(function() {
	function close_accordion_section() {
		jQuery('.accordion .accordion-section-title').removeClass('active');
		jQuery('.accordion .accordion-section-content').slideUp(300).removeClass('open');
	}

	jQuery('.accordion-section-title').click(function(e) {
// Grab current anchor value
var currentAttrValue = jQuery(this).attr('href');

if(jQuery(e.target).is('.active')) {
	close_accordion_section();
}else {
	close_accordion_section();

// Add active class to section title
jQuery(this).addClass('active');
// Open up the hidden content panel
jQuery('.accordion ' + currentAttrValue).slideDown(300).addClass('open'); 
}

e.preventDefault();
});
});