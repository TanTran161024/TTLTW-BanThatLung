package com.thomas.controller;

import com.thomas.dao.model.Belts;
import com.thomas.dao.model.Collection;
import com.thomas.dao.model.CollectionDetails;
import com.thomas.services.UploadProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "addCollectionDetailsController", value = "/add-Collection-details")
public class addCollectionDetailsController extends HttpServlet {
    UploadProductService uploadProductService = new UploadProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));
        int collectionId = Integer.parseInt(request.getParameter("orderId"));
        Belts belt = null;
        List<Belts> allBelts = uploadProductService.getProducts();
        for (Belts b : allBelts) {
            if (b.getName().equals(productName.trim())) {
                belt = b;
            }
        }
        CollectionDetails cd = new CollectionDetails();
        cd.setCollectionId(collectionId);
        cd.setCreatedAt(LocalDate.now());
        cd.setBeltId(belt.getId());
        uploadProductService.saveCollection(cd);
        PrintWriter out = response.getWriter();
        out.write("{");
        out.write("\"id\": " + cd.getBeltId() + ",");
        out.write("\"beltName\": \"" + belt.getName() + "\",");
        out.write("\"releaseDate\": " + belt.getReleaseDate() + ",");
        out.write("\"price\": \"" + String.format("%.2f", belt.getPrice()) + "\"");
        out.write("}");
        out.flush();
    }
}

