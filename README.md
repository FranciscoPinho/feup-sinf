# Online web store

Online store with interoperability with PRIMAVERA ERP

##Project Overview 
The project consists on the creation of a web store that offers all the functionalities expected from such a site, like:

* Account register and login (two way verification through primavera and our postgresql database).
* Product browsing, with category filters and search by name.
* Check metrics of a product: price,description,rating, written reviews and available units
* Add products to the cart.
* Finalize product purchase.
* Check the availability of the product (current stock).
* Check the order status of a purchase and review associated products.
* Check order history, with all details related to the purchases.
* Rate and review purchased products
* Administration capabilities, allowing the hypothetical maintenance team to add images to the products

In order to achieve the goals for our product  and build these functionalities, we created an external layer (running on the browser), so as to implement the online store View component. This was done by creating a web app, using C# ASP.Net that implements the views by using ASP.Net’s MVC (Model View Controller) framework. 
This Web App accesses and uses the services of the PRIMAVERA REST API for the Model and Controller components, as required, which means the web app is an external extension of it, up to a certain point. We did not do a full coverage on all the PRIMAVERA capabilities, like inventory management, or dashboard overviews, which are out of this project’s scope. In addition to the PRIMAVERA API services, we extended the store with our own Database to implement the product rating, reviews and image editing.
