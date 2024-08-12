
<%@page import="com.learn.mycart.helper.helper"%>
<%@page import="org.hibernate.boot.model.source.internal.hbm.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyShop - Home</title>
        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %> 
        <div class="container-fluid">
            <div class="row mt-3 mx-2 ">
                <%                    String cat = request.getParameter("category");

                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    if (cat == null || cat.trim().isEmpty() || cat.trim().equals("all")) {
                        list = dao.getAllProducts();
                    } else {
                        int cid = Integer.parseInt(cat.trim());
                        list = dao.getAllProductsById(cid);
                    }

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> listc = cdao.getCategories();

                %>
                <!--show categories-->
                <div class="col-md-2 card-shows">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All products
                        </a>



                        <%                    for (Category category : listc) {


                        %>
                        <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action"><%= category.getCategoryTitle()%></a>


                        <%        }
                        %>
                    </div>
                </div>

                <!--show products-->
                <div class="col-md-10">

                    <!--row-->
                    <div class="row mt-4">
                        <!--col:12-->
                        <div class="col-md-12">
                            <div class="card-columns">
                                <!--traversing product-->

                                <%
                                    for (Product p : list) {
                                %>

                                <!--product card-->
                                <div class="card product-card">
                                    <div class="container text-center">
                                        <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 200px;max-width: 100%;width: auto " class="card-img-top m-2" alt="">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%=  p.getpName()%></h5>
                                        <p class="card-text">
                                            <%=helper.get10Words(p.getpDesc())%>
                                        </p>
                                    </div>

                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>',<%= p.getPriceAfterApplyingDiscount()%>)">Add to Cart</button>
                                        <button class="btn btn-outline-success">&#8377 <%= p.getpPrice()%>/- <span class="text-secondary discount-label"> <%= p.getpDiscount()%> off (&#8377;<%= p.getPriceAfterApplyingDiscount()%>)  </span>  </button>
                                    </div>
                                </div>

                                <%
                                    }
                                    if (list.size() == 0) {
                                        out.println("<h3>No item in this category</h3>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>                
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
