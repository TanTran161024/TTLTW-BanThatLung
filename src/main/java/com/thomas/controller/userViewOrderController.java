package com.thomas.controller;

import com.thomas.dao.model.Order;
import com.thomas.dao.model.OrderDetails;
import com.thomas.dao.model.User;
import com.thomas.services.UploadOrderDetailService;
import com.thomas.services.UploadOrderService;
import com.thomas.services.UploadProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "userViewOrderController", value = "/viewOrders")
public class userViewOrderController extends HttpServlet {
    UploadProductService uploadProductService = new UploadProductService();
    UploadProductService uploadProductService2 = new UploadProductService();
    UploadOrderService uploadOrderService = new UploadOrderService();
    UploadOrderDetailService uploadOrderDetailService = new UploadOrderDetailService();
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    DecimalFormat formatter = new DecimalFormat("#,###.000", symbols);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        symbols.setGroupingSeparator(',');
        symbols.setDecimalSeparator('.');
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        List<Order> userOrders = uploadOrderService.getAllOrdersByUserId(user.getId());
        for (Order order : userOrders) {
            uploadOrderDetailService.setOrderDetails(order);
        }
        for (Order order : userOrders) {
            for (OrderDetails od : order.getOrderDetails()) {
                od.setBeltImages(uploadProductService.getProductImages(od.getBeltId()));
                od.setCategories(uploadProductService.getAllCategoriesById(od.getBeltId()));
                uploadOrderDetailService.setBeltName(od);
            }
            order.setShippingDate();
        }
        Collections.sort(userOrders, new Comparator<Order>() {

            @Override
            public int compare(Order o1, Order o2) {
                return o2.getOrderDate().compareTo(o1.getOrderDate());
            }
        });
        request.setAttribute("orders", userOrders);
        request.getRequestDispatcher("/frontend/userInfoPage/orderView/ordersView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}

