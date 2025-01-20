

document.querySelector('.explore').addEventListener('click', function() {
    var extraContent = document.querySelector('.extra');
    var icon = document.querySelector('.explore i');

    if (extraContent.style.display === 'none') {
        extraContent.style.display = 'block'; // Show the extra content
        icon.classList.remove('fa-plus');
        icon.classList.add('fa-minus');
    } else {
        extraContent.style.display = 'none'; // Hide the extra content
        icon.classList.remove('fa-minus');
        icon.classList.add('fa-plus');
    }
}
);
const carousel = document.querySelector('.carousel-items');
const members = document.querySelectorAll('.member');
const totalMembers = members.length;
const slidesToShow = 3;
const slideWidth = 100 / slidesToShow;

// Cloning only the necessary members
for (let i = 0; i < slidesToShow; i++) {
    const cloneFirst = members[i].cloneNode(true);
    carousel.appendChild(cloneFirst);
}

let currentSlide = 0;

function updateCarousel() {
    const offset = -(currentSlide * slideWidth);
    carousel.style.transform = `translateX(${offset}%)`;
    carousel.style.transition = 'transform 0.5s ease';
}

function resetPosition(slide) {
    const offset = -(slide * slideWidth);
    carousel.style.transition = 'none'; // Disable transition for instant jump
    carousel.style.transform = `translateX(${offset}%)`;
    currentSlide = slide; // Reset the current slide index
}

document.querySelector('.next').addEventListener('click', () => {
    currentSlide++;
    if (currentSlide > totalMembers - 1) {
        updateCarousel();
        setTimeout(() => resetPosition(0), 500); // Reset after transition
    } else {
        updateCarousel();
    }
});

document.querySelector('.prev').addEventListener('click', () => {
    currentSlide--;
    if (currentSlide < 0) {
        resetPosition(totalMembers - 1); // Immediately move to the last clone
        setTimeout(() => updateCarousel(), 20); // Update the view to show smooth transition
    } else {
        updateCarousel();
    }
});

document.querySelector('.carousel-inner').addEventListener('wheel', (event) => {
    event.preventDefault();
    if (event.deltaY > 0) {
        document.querySelector('.next').click();
    } else {
        document.querySelector('.prev').click();
    }
});

// Initial update to set the carousel in the correct position
updateCarousel();
