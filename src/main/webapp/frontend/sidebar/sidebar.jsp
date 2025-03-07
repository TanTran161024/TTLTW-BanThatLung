<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="py-2 collapse-inner rounded" style="background-color:#dddddd;">
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/users") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/users">
        Người dùng
    </a>
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/belts") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/belts">
        Sản phẩm
    </a>
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/reviews") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/reviews">
        Đánh giá
    </a>
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/coupons") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/coupons">
        Coupon
    </a>
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/orders") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/orders">
        Đơn hàng
    </a>
    <a class="collapse-item <%= request.getRequestURI().contains("/admin/table/collections") ? "active" : "" %>"
       href="${pageContext.request.contextPath}/admin/table/collections">
        Bộ sưu tập
    </a>
</div>
