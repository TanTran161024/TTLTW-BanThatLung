<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Product Detail</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/icons/favicon.svg" type="image/png"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/fontawesome-free-6.6.0-web/fontawesome-free-6.6.0-web/css/all.css"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css"/>
    <script src="${pageContext.request.contextPath}/js/productDetail.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/general.css"/>
    <script src="${pageContext.request.contextPath}/js/favorite.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/favorite.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productDetail.css"/>
</head>

<body>
<jsp:include page="/frontend/header_footer/header.jsp"/>

<div class="breadcumb__container">
    <nav style="--bs-breadcrumb-divider: '>'" aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
            </li>
            <li class="breadcrumb-item active" aria-current="page">Sản phẩm</li>
        </ol>
    </nav>
</div>

<div class="my-5 bg-white rounded mb-0 ps-3 py-2 pe-4">
    <div class="d-flex">
        <div class="col-md-9 d-flex">
            <div class="col-2 belts-thumbnails d-flex flex-column align-item-start justify-content-between mt-0 me-2">
                <c:forEach var="image" items="${variant.images}" varStatus="status">
                    <img src="${pageContext.request.contextPath}${image}"
                         class="${status.index!=4 ? "mb-2":""} w-50"
                         alt="Thumbnail ${status.index+1}" data-bs-target="#productCarousel"
                         data-bs-slide-to="${status.index}"/>
                </c:forEach>

            </div>
            <div id="productCarousel" class="carousel slide col-2 belts w-75">
                <div class="carousel-inner">
                    <c:set var="globalIndex" value="0" scope="page"/>
                    <c:forEach var="image" items="${variant.images}" varStatus="status">
                        <div class="carousel-item ${globalIndex == 0 ? "active":""}">
                            <img src="${pageContext.request.contextPath}${image}"
                                 class="img-fluid"
                                 alt="Product Image ${globalIndex}"/>
                        </div>
                        <c:set var="globalIndex" value="${globalIndex + 1}" scope="page"/>
                    </c:forEach>

                </div>
                <button class="carousel-control-prev custom_shadow" type="button" data-bs-target="#productCarousel"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <div class="col-md-3 beltProp" style="position: relative">
            <input type="hidden" class="beltId" value="${belt.id}">
            <input type="hidden" class="variantId" value="${variant.id}">
            <input type="hidden" class="userId" value="${sessionScope.auth.id}">
            <h2 class="product_detail--name">${belt.name}</h2>
            <c:choose>
                <c:when test="${belt.discountRate > 0}">
                    <p class="belts-price text-danger" style="font-size: 32px;">
                        <fmt:formatNumber value="${belt.price - (belt.price * belt.discountRate / 100)}"
                                          type="number" maxFractionDigits="3"/>
                        VNĐ
                        <span class="belts-old-price text-muted text-decoration-line-through">
                                ${belt.price} VNĐ
                        </span>
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="belts-price">
                            ${belt.price} VNĐ
                    </p>
                </c:otherwise>
            </c:choose>


            <div class="mb-3">
                <c:forEach var="category" items="${beltCategory}">
                    <strong class="p-2 me-2" style="background-color: #DFDFDF">${category.name}</strong>
                </c:forEach>
            </div>
            <div class="mb-3 mt-3">
                <label for="quantity" class="form-label fw-5"><strong>Số Lượng:</strong></label>
                <input type="hidden" class="quantity_belt" name="quantity" value="${variant.stockQuantity}">
                <div class="quantity__control input-group quantity-controls">
                    <button class="btn btn-outline-secondary rounded-0 p-4 border-end-0 py-2 px-3" type="button"
                            id="decrement">
                        -
                    </button>
                    <input type="text" class="px-1 py-2 border-start-0 border-end-0 w-25" id="quantity" value="1">
                    <button class="btn btn-outline-secondary rounded-0 p-4 border-start-0 py-2 px-3" type="button"
                            id="increment">
                        +
                    </button>
                </div>
            </div>
            <div class="mb-3 mt-3">
                <label for="quantity" class="form-label fw-5"><strong>Màu sắc:</strong></label>
                <div class="d-flex flex-wrap gap-2">
                    <c:forEach var="variant" items="${allVariant}">
                        <a href="/productDetails?beltId=${param.beltId}&variantId=${variant.id}"
                           class="variantTag text-black d-inline-flex align-items-start"
                           style="flex-direction: column; width: 100px">
                            <img class="img-fluid" src="${variant.images[0]}"/>
                            <span>${variant.color} / ${variant.size!=null? variant.size:""}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="mb-3 mt-2">
                <label for="quantity" class="form-label fw-5"><strong>Size:</strong></label>
                <div class="d-flex gap-2">
                    <c:set var="sizes" value="XS,S,M,L,XL"/>

                    <c:forEach var="size" items="${fn:split(sizes, ',')}">
                        <c:set var="exists" value="false"/>

                        <c:forEach var="variant" items="${similarVariants}">
                            <c:if test="${variant.size eq size}">
                                <c:set var="exists" value="true"/>
                            </c:if>
                        </c:forEach>

                        <a href="${pageContext.request.contextPath}/productDetails?beltId=${param.beltId}&variantId=${variant.id}&variantColor=${variant.color}&variantSize=${variant.size}"
                           class="variantTag text-black d-inline-flex justify-content-center align-items-center p-2"
                           style="background-color: ${exists ? 'darkgray' : 'lightgray'}; opacity: ${exists ? '1' : '0.5'}; pointer-events: ${exists ? 'auto' : 'none'}; border-radius: 0; min-width: 50px; text-align: center;">
                            <p class="m-0">${size}</p>
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="mb-3 d-flex flex-column align-item-center">
                <form method="POST" action="/buyNow">
                    <input type="hidden" name="beltId" value="${belt.id}">
                    <input type="hidden" name="variantId" value="${variant.id}">
                    <c:choose>
                        <c:when test="${belt.discountRate > 0}">
                            <input type="hidden" name="price"
                                   value=" ${belt.price - (belt.price * belt.discountRate / 100)}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="price"
                                   value=" ${belt.price}">
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${sessionScope.auth==null}">
                            <button type="submit" href="" class="buyNow__button btn btn-dark w-100 mb-4" disabled>
                                Mua Ngay
                            </button>
                            <p class="p-0">Dăng nhập để mua sản phẩm</p>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" href="" class="buyNow__button btn btn-dark w-100 mb-4">
                                Mua Ngay
                            </button>
                        </c:otherwise>
                    </c:choose>

                </form>

                <button class="addToCart__button btn-white me-2 w-100 mb-3" id="liveToastBtn" type="button">
                    Thêm vào giỏ hàng
                </button>
                <button type="button" class="favorite_button btn me-2 w-100 mb-3 rounded" id="liveToastBtn">
                    <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px"
                         fill="#000000">
                        <path
                                d="m480-120-58-52q-101-91-167-157T150-447.5Q111-500 95.5-544T80-634q0-94 63-157t157-63q52 0 99 22t81 62q34-40 81-62t99-22q94 0 157 63t63 157q0 46-15.5 90T810-447.5Q771-395 705-329T538-172l-58 52Zm0-108q96-86 158-147.5t98-107q36-45.5 50-81t14-70.5q0-60-40-100t-100-40q-47 0-87 26.5T518-680h-76q-15-41-55-67.5T300-774q-60 0-100 40t-40 100q0 35 14 70.5t50 81q36 45.5 98 107T480-228Zm0-273Z"/>
                    </svg>
                    Thêm vào yêu thích
                </button>
            </div>
        </div>
    </div>
</div>
<div class="d-flex flex-column ms-5">
    <section class="content-item">
        <div id="navigation-target-description">
            <div data-testid="accordion" class="accordion">
                <!-- Phần header của accordion -->
                <button class="accordion__header">
                    <div class="accordion__header-text">
                        <h2 class="accordion-title">Mô tả</h2>
                    </div>
                    <div class="accordion__header-icon">
                    <span data-testid="dropdown" class="icon-wrapper" role="img">
                        <!-- Sử dụng icon mũi tên từ FontAwesome -->
                        <i class="fas fa-chevron-down"></i>
                    </span>
                    </div>
                </button>

                <!-- Phần nội dung của accordion -->
                <div class="accordion__content">
                    <div class="content-padding">
                        <div class="description">
                            <!-- Phần văn bản mô tả -->
                            <div class="text-content">
                                <p class="gl-vspace">${belt.description}</p> <!-- Dữ liệu động từ biến -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="content-item">
        <div id="navigation-target-reviews">
            <div data-testid="accordion" class="accordion">
                <!-- Phần header của accordion đánh giá -->
                <button class="accordion__header">
                    <div class="accordion__header-text">
                        <h2 class="accordion-title">Đánh giá</h2>
                    </div>
                    <div class="accordion__header-icon">
                    <span data-testid="dropdown" class="icon-wrapper" role="img">
                        <i class="fas fa-chevron-down"></i>
                    </span>
                    </div>
                </button>

                <!-- Phần nội dung của accordion đánh giá -->
                <div class="accordion__content">
                    <div class="content-padding">
                        <div class="d-flex flex-column justify-content-center">
                            <input id="beltIdReviews" type="hidden" name="beltId" value="${belt.id}">
                            <input id="variantIdReviews" type="hidden" name="variantId" value="${variant.id}">
                            <div class="d-flex justify-content-center flex-column">
                                <p class="fs-3">${totalReview} đánh giá</p>
                                <div class="d-flex border-bottom mb-3">
                                    <p class="mb-0 fs-4">Đánh giá cho sản phẩm này</p>
                                    <span class="ps-3 pe-3 pb-1 pt-1 ms-2 bg-light rounded-pill mb-2">${totalReview}</span>
                                </div>
                                <div id="reviewsContainer">

                                </div>
                            </div>
                            <section class="d-flex justify-content-end">
                                <nav aria-label="Page__navigation__example" id="pagination__bar">
                                    <div class="container paginationWrapper ps-0">
                                        <ul class="pagination pagination__Ul">

                                        </ul>
                                    </div>
                                </nav>
                            </section>
                            <c:if test="${sessionScope.auth.id!=null && isPurchasedBelt}">
                                <div class="d-flex flex-column mt-5 custom_bg p-4">
                                    <form action="${pageContext.request.contextPath}/productDetails" method="POST">
                                        <input type="hidden" name="userId" value="${sessionScope.auth.id}">
                                        <input type="hidden" name="message" value="postComment">
                                        <input type="hidden" name="beltId" value="${belt.id}">
                                        <input type="hidden" name="variantId" value="${variant.id}">
                                        <h2>Viết đánh giá</h2>
                                        <div class="row mt-2">
                                            <div class="d-flex align-item-center">
                                                <img src="${pageContext.request.contextPath}${variant.images[0]}"
                                                     class=""
                                                     alt="..." width="200px"/>
                                                <div class="ms-4">
                                                    <h5 class="card-title text-start fs-6">
                                                            ${belt.name}
                                                    </h5>
                                                    <div class="rating-card ">
                                                        <div class="star-rating animated-stars">
                                                            <input type="radio" id="star5" name="rating" value="5">
                                                            <label for="star5" class="bi bi-star-fill"></label>
                                                            <input type="radio" id="star4" name="rating" value="4">
                                                            <label for="star4" class="bi bi-star-fill"></label>
                                                            <input type="radio" id="star3" name="rating" value="3">
                                                            <label for="star3" class="bi bi-star-fill"></label>
                                                            <input type="radio" id="star2" name="rating" value="2">
                                                            <label for="star2" class="bi bi-star-fill"></label>
                                                            <input type="radio" id="star1" name="rating" value="1">
                                                            <label for="star1" class="bi bi-star-fill"></label>
                                                        </div>
                                                    </div>
                                                    <textarea name="desc" class="pt-2 ps-1 mt-4" cols="70" rows="5"
                                                              style="resize: none">
                                                    </textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex ms-3">
                                            <c:choose>
                                                <c:when test="${sessionScope.auth.image == null}">
                                                    <img src="${pageContext.request.contextPath}/assets/icons/default_profile.svg"
                                                         alt="User Avatar"

                                                         class="mt-3" width="50px" height="50px">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${sessionScope.auth.image}"
                                                         alt="User Avatar"

                                                         class="mt-3" width="50px" height="50px">
                                                </c:otherwise>
                                            </c:choose>
                                            <p class="mt-4 ms-3">Đánh giá bởi ${sessionScope.auth.name}</p>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <c:choose>
                                                <c:when test="${sessionScope.auth != null}">
                                                    <button type="submit" class="btn btn-dark me-4 p-2 px-3 mt-3">Gửi
                                                        đánh
                                                        giá
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/login"
                                                       class="btn btn-dark me-4 p-2 px-3 mt-3">Gửi
                                                        đánh giá</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                    </form>


                                </div>

                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="viewed__component ps-5 pt-3 youmightlike__component mb-5 pe-5 pb-5"
     style="margin-top: 200px">
    <p class="viewed__title ms-0 fs-2">Bạn có thể thích</p>
    <div class="d-flex justify-content-between">
        <div class="card-wrapper cardWrapper">
            <c:forEach var="belt" items="${randomBelts}">
                <a href="productDetails?beltId=${belt.id}&variantId=${belt.beltVariants[0].id}"
                   class="text-decoration-none text-dark">
                    <div class="text-center hover--black">
                        <!-- Hiển thị ảnh của biến thể đầu tiên -->
                        <c:if test="${not empty belt.beltVariants}">
                            <c:set var="firstVariant" value="${belt.beltVariants[0]}"/>
                            <c:if test="${not empty firstVariant.images}">
                                <img src="${pageContext.request.contextPath}${firstVariant.images[0]}"
                                     class="img-fluid w-100 rounded shadow-sm"
                                     alt="${belt.name}"
                                     style="height: 25rem; object-fit: cover;">
                            </c:if>
                        </c:if>

                        <!-- Thông tin sản phẩm -->
                        <div class="mt-2 text-start ps-3">
                            <p class="fw-bold fs-5 mb-1">${belt.price} VNĐ</p>
                            <p class="text-muted mb-1">${belt.name}</p>
                            <span class="badge bg-secondary">${belt.discountRate}%</span>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<div class="viewed__component ps-5 pt-3 youmightlike__component mb-5 pe-5 pb-5">
    <p class="viewed__title ms-0 fs-2">Sản phẩm xem nhiều nhất</p>
    <div class="d-flex justify-content-between">
        <div class="card-wrapper cardWrapper">
            <c:forEach var="belt" items="${randomBelts}">
                <a href="productDetails?beltId=${belt.id}&variantId=${belt.beltVariants[0].id}"
                   class="text-decoration-none text-dark">
                    <div class="text-center hover--black">
                        <!-- Hiển thị ảnh của biến thể đầu tiên -->
                        <c:if test="${not empty belt.beltVariants}">
                            <c:set var="firstVariant" value="${belt.beltVariants[0]}"/>
                            <c:if test="${not empty firstVariant.images}">
                                <img src="${pageContext.request.contextPath}${firstVariant.images[0]}"
                                     class="img-fluid w-100 rounded shadow-sm"
                                     alt="${belt.name}"
                                     style="height: 25rem; object-fit: cover;">
                            </c:if>
                        </c:if>

                        <!-- Thông tin sản phẩm -->
                        <div class="mt-2 text-start ps-3">
                            <p class="fw-bold fs-5 mb-1">${belt.price} VNĐ</p>
                            <p class="text-muted mb-1">${belt.name}</p>
                            <span class="badge bg-secondary">${belt.discountRate}%</span>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 11">
    <div id="liveToast" class="toast hide bg-white" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-body fs-5 p-3 d-flex justify-content-between border-end border-dark border-5 align-items-center">
            <i class="bi bi-info-circle"></i>
            <p class="fs-5 m-0 custom_toast_text">Thêm vào thành công</p>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<script>
    document.querySelectorAll('.star-rating:not(.readonly) label').forEach(star => {
        star.addEventListener('click', function () {
            this.style.transform = 'scale(1.2)';
            setTimeout(() => {
                this.style.transform = 'scale(1)';
            }, 200);
        });
    });
</script>
<script>
    document.querySelector("#increment").addEventListener("click", () => {
        const stockQuantity = $(".quantity_belt").val();
        let quantity = document.querySelector("#quantity");
        if (parseInt(quantity.value) < stockQuantity) {
            quantity.value = parseInt(quantity.value) + 1;
        }
    });

    document.querySelector("#decrement").addEventListener("click", () => {
        let quantity = document.querySelector("#quantity");
        if (parseInt(quantity.value) > 1) {
            quantity.value = parseInt(quantity.value) - 1;
        }
    });
    document.querySelectorAll('.star-rating:not(.readonly) label').forEach(star => {
        star.addEventListener('click', function () {
            this.style.transform = 'scale(1.2)';
            setTimeout(() => {
                this.style.transform = 'scale(1)';
            }, 200);
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
        const descriptionHeader = document.querySelector("#navigation-target-description .accordion__header");
        const descriptionContent = document.querySelector("#navigation-target-description .accordion__content");
        const descriptionArrow = document.querySelector("#navigation-target-description .fa-chevron-down");

        descriptionHeader.addEventListener("click", function () {
            descriptionContent.classList.toggle("active");
            descriptionArrow.style.transform = descriptionContent.classList.contains("active") ? "rotate(180deg)" : "rotate(0deg)";
        });

        const reviewsHeader = document.querySelector("#navigation-target-reviews .accordion__header");
        const reviewsContent = document.querySelector("#navigation-target-reviews .accordion__content");
        const reviewsArrow = document.querySelector("#navigation-target-reviews .fa-chevron-down");

        reviewsHeader.addEventListener("click", function () {
            reviewsContent.classList.toggle("active");
            reviewsArrow.style.transform = reviewsContent.classList.contains("active") ? "rotate(180deg)" : "rotate(0deg)";
        });
    });
</script>
<jsp:include page="/frontend/header_footer/footer.jsp"/>

</body>

</html>