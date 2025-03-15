$(document).ready(function () {
        let dropdown = $(".search-dropdown");
        let productList = $("#list__product__row");

        function showDropdown(query) {
            dropdown.empty();

            if (query.length > 0) {
                $.ajax({
                    url: `/search?q=${encodeURIComponent(query)}`,
                    method: "GET",
                    success: function (data) {
                        // Xóa danh sách cũ
                        productList.empty();

                        if (data.length > 0) {
                            data.forEach(item => {
                                // Cập nhật dropdown
                                dropdown.append(`
                                <a class="dropdown-item text-light" href="/productDetails?beltId=${item.id}">
                                    ${item.name}
                                </a>
                            `);

                                // Thêm sản phẩm vào danh sách
                                productList.append(`
                                <div class="col product__col d-flex flex-wrap" style="width: 50%">
                                    <a href="/productDetails?beltId=${item.id}" class="text-decoration-none">
                                        <div class="belts h-100 d-flex flex-column">
                                            <div class="ratio ratio-1x1">
                                                <img src="${item.image[0]}" class="img-fluid object-fit-cover" alt="${item.name}"/>
                                            </div>
                                            <div class="product__title mt-auto text-center">
                                                <h4 class="title">${item.name}</h4>
                                                <p class="product__price">${item.price} VNĐ</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            `);
                            });
                        } else {
                            dropdown.append(`<div class="dropdown-item text-muted">No results found</div>`);
                            productList.append(`<p class="text-muted text-center">Không tìm thấy sản phẩm nào.</p>`);
                        }
                    },
                    error: function () {
                        dropdown.append(`<div class="dropdown-item text-danger">Lỗi khi lấy dữ liệu</div>`);
                    }
                });
            }
        }

        dropdown.addClass("show");
        $(".search__input").on("input click", function () {
            showDropdown($(this).val().trim());
            $(".dimmer").addClass("active");
            $(".search_container").css("z-index", "1");
        });

// Hide dropdown when clicking outside
        $(document).on("click", function (e) {
            if (!$(e.target).closest(".search__input, .search-dropdown").length) {
                dropdown.removeClass("show");
                $(".dimmer").removeClass("active");

            }
        });
    }
)
;