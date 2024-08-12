<%@page import="com.learn.mycart.helper.helper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in");
        response.sendRedirect("login.jsp");
        return;

    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not Admin !!");
            response.sendRedirect("login.jsp");
            return;
        }

    }


%>

<%  CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cDao.getCategories();

//getting count 
Map<String,Long> m = helper.getCounts(FactoryProvider.getFactory());

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel - MyShop</title>
        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %> 
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>

            </div>
            <!--first row-->
            <div class="row mt-3">

                <!--first column-->
                <div class="col-md-4">

                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 115px;" class="img-fluid rounded-circle"  src="img/Users.png" alt="user_icon">
                            </div>
                            <h1><%= m.get("userCount") %> </h1>
                            <h1 class= "text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>

                <!--second column-->
                <div class="col-md-4">

                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 115px;" class="img-fluid rounded-circle"  src="img/list.png" alt="user_icon">
                            </div>
                            <h1><%= list.size()%></h1>
                            <h1 class= "text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>        
                </div>

                <!--third column-->
                <div class="col-md-4">

                    <div class="card ">

                        <div class="card-body text-center ">
                            <div class="container">
                                <img style="max-width: 115px;" class="img-fluid rounded-circle"  src="img/product.png" alt="user_icon">
                            </div>
                            <h1><%= m.get("productCount") %></h1>
                            <h1 class= "text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!--second row-->
            <div class="row mt-3">
                <!--second row: first column-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">

                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 115px;" class="img-fluid rounded-circle"  src="img/keys.png" alt="user_icon">
                            </div>
                            <p class="mt-3">Click here to add new category</p>
                            <h1 class= "text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>

                <!--second row : second column-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">

                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 115px;" class="img-fluid rounded-circle"  src="img/plus.png" alt="user_icon">
                            </div>
                            <p class="mt-3">Click here to add new Product</p>
                            <h1 class= "text-uppercase text-muted">Add Products</h1>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <!--add category modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addCategory" />
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter the category title" required />

                            </div>

                            <div class="form-group">
                                <textarea style="height: 225px" class="form-control" placeholder="Enter the Category description" name="catDescription" required></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>

                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!--end add category modal-->

        <!--product modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addProduct" />
                            <!--product title-->
                            <div class="from-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter the title of the product" required />
                            </div>

                            <!--product description-->
                            <div class="form-group">
                                <textarea style="height: 150px" class="form-control mt-3" name="pDesc" placeholder="Enter the product details"></textarea>
                            </div>

                            <!--product price-->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter the price of the product" required />
                            </div>

                            <!--product discount-->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter the discount of the product" required />
                            </div>

                            <!--product Quantity-->
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter the quantity of the product" required />
                            </div>


                            <!--product category-->
                            <div class="form-group">
                                <select name ="catId" class="form-control" id="">
                                    <%for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"> <%=c.getCategoryTitle()%> </option>

                                    <%}
                                    %>
                                </select>
                            </div>

                            <!--product file-->
                            <div class="form-group">
                                <label for="pPic">Select Picture of Product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" required />
                            </div>

                            <!--submit button-->
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                            </div>

                        </form>




                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>



        <!--end product modal-->
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
