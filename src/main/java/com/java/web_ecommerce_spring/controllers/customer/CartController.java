package com.java.web_ecommerce_spring.controllers.customer;

import com.java.web_ecommerce_spring.domain.*;
import com.java.web_ecommerce_spring.models.AddDiscountCode;
import com.java.web_ecommerce_spring.models.ChangeNumber;
import com.java.web_ecommerce_spring.models.ItemModel;
import com.java.web_ecommerce_spring.models.OrderItem;
import com.java.web_ecommerce_spring.services.*;
import com.java.web_ecommerce_spring.utils.Middleware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/public/cart")
public class CartController {

    @Autowired
    ProductService productService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    OrderService orderService;

    @Autowired
    OrderDetailService orderDetailService;

    @Autowired
    MessageSource messageSource;

    @Autowired
    DiscountCodeService discountCodeService;


    Middleware middleware = new Middleware();

    @GetMapping(value = "/index")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView("public/cart");
        mv.addObject("categories",categoryService.getAll());
        return mv;
    }

    @GetMapping(value = "/delete/{productId}")
    public ModelAndView delete(@PathVariable int productId,HttpServletRequest request){
        ModelAndView mv = new ModelAndView("redirect:/public/cart/index");
        Product product = productService.getProductById(productId);
        HttpSession session = request.getSession();
        OrderItem order = (OrderItem) session.getAttribute("order");
        List<ItemModel> listItem = order.getItemModels();
        int total = 0;
        for (int i = 0 ; i< listItem.size() ;i++){
            if (listItem.get(i).getProduct().getId() == productId) {
                listItem.remove(i);
            }
        }
        for (int i = 0 ; i< listItem.size() ;i++){
            total += (listItem.get(i).getProduct().getPrice() - (listItem.get(i).getProduct().getPrice() * listItem.get(i).getProduct().getDiscount()/ 100) )* listItem.get(i).getQuantity();
        }
        order.setItemModels(listItem);
        order.setTotal(total + 3);
        session.setAttribute("order", order);
        return mv;
    }

    @PostMapping(value = "/add/{key}")
    public @ResponseBody int add(@PathVariable String key, HttpServletRequest request){
        int quantity = 1;
        int numberCart = 0;
        int total = 0;
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        Product product = productService.getProductById(Integer.parseInt(productId));
        OrderItem orderItem1 = (OrderItem) session.getAttribute("order");

        quantity = Integer.parseInt(request.getParameter("quantity"));

        if(orderItem1 != null){
            ItemModel obj = null;
            for(int i = 0 ; i< orderItem1.getItemModels().stream().count() ; i++){
                if(orderItem1.getItemModels().get(i).getProduct().getId() == product.getId()){
                    obj = orderItem1.getItemModels().get(i);
                    if(obj != null){
                        if(obj.getQuantity()+quantity > product.getQuantity()){
                            return  0;
                        }
                    }
                }
            }
        }
        if (quantity > product.getQuantity()){
            return  0;
        }
        OrderItem orderItem = new OrderItem();
        if (productId != null){
            if (session.getAttribute("order") == null) {
                List<ItemModel> listItem = new ArrayList<>();
                ItemModel item = new ItemModel(product,quantity);
                listItem.add(item);
                orderItem.setItemModels(listItem);
                session.setAttribute("order", orderItem);
            } else {
                orderItem = (OrderItem) session.getAttribute("order");
                List<ItemModel> listItem = orderItem.getItemModels();
                boolean check = false;
                for (ItemModel item:listItem) {
                    if(item.getProduct().getId()== product.getId()) {
                        item.setQuantity(item.getQuantity()+quantity);
                        check = true;
                    }
                }
                if (check == false ) {
                    ItemModel item = new ItemModel(product,quantity);
                    listItem.add(item);
                    orderItem.setItemModels(listItem);
                    session.setAttribute("order", orderItem);
                }
            }
        }
        OrderItem order1 = (OrderItem) session.getAttribute("order");
        for(ItemModel itemModel:order1.getItemModels()){
            numberCart+=1;
            total +=( itemModel.getProduct().getPrice() - (itemModel.getProduct().getPrice() * itemModel.getProduct().getDiscount()/ 100)) * itemModel.getQuantity();
        }
        int totalHasFee = total + 3;
        orderItem.setTotal(totalHasFee);
        session.setAttribute("order", orderItem);
        if("buyNow".equalsIgnoreCase(key)){
            return 123456;
        }
        return numberCart;
    }

    @PostMapping("/update-number")
    public @ResponseBody ChangeNumber updateNumber(HttpServletRequest request){
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Product product = productService.getProductById(productId);
        int total = 0;
        HttpSession session = request.getSession();
        OrderItem orderItem = (OrderItem) session.getAttribute("order");
        List<ItemModel> listItem = orderItem.getItemModels();
        for (int i = 0 ; i<listItem.size() ; i++){
            if(listItem.get(i).getProduct().getId() == productId){
                listItem.get(i).setQuantity(quantity);
            }
        }
        for (int i = 0 ; i< listItem.size() ;i++){
            total += (listItem.get(i).getProduct().getPrice() - (listItem.get(i).getProduct().getPrice() * listItem.get(i).getProduct().getDiscount()/ 100)) * listItem.get(i).getQuantity();
        }
        orderItem.setItemModels(listItem);
        orderItem.setTotal(total + 3);
        int giacu = product.getPrice()*quantity;
        int giamoi = (product.getPrice() - (product.getPrice()* product.getDiscount()/100))*quantity;
        int tongtien = total;
        int tamTinh = total + 3;
        ChangeNumber changeNumber = new ChangeNumber(giacu,giamoi,tongtien,tamTinh);
        if(quantity > product.getQuantity()){
            ChangeNumber changeNumber1 = new ChangeNumber(0,0,0,0);
            return changeNumber1;
        }
        return changeNumber;
    }

    @PostMapping("/add-discount-code")
    public @ResponseBody AddDiscountCode addDiscountCode(HttpServletRequest request) throws ParseException {
        DecimalFormat formatter = new DecimalFormat("###,###,###");
        String discountCode = request.getParameter("discountCode");
        int number = Integer.parseInt(request.getParameter("number")) ;
        DiscountCode obj = discountCodeService.findDiscountCodeByCode(discountCode);
        HttpSession session = request.getSession();
        OrderItem orderItem = (OrderItem) session.getAttribute("order");
        List<ItemModel> listItem = orderItem.getItemModels();
        AddDiscountCode discountCode1 = new AddDiscountCode();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //Để khai báo những giá trị mới trong đối tượng date mới, hãy sử dụng cùng định dạng khi tạo ngày.

        if(number == 0){
            if(obj == null){

                int total1 = 0;
                for (int i = 0 ; i< listItem.size() ;i++){
                    total1 += (listItem.get(i).getProduct().getPrice() - (listItem.get(i).getProduct().getPrice() * listItem.get(i).getProduct().getDiscount()/ 100)) * listItem.get(i).getQuantity();
                }
//                orderItem.setTotal(total1);
                discountCode1.setStatus(0);
                discountCode1.setTotal(total1);
                return discountCode1;
            }else{
                Date startDate = sdf.parse(obj.getStartDate()); //date1 là 23/2/1995
                Date endDate = sdf.parse(obj.getEndDate()); //date2 là 31/10/2001
                Date dataNow = sdf.parse(java.time.LocalDate.now().toString()); //date3 là 23/2/1995
                if(dataNow.before(startDate)){
                    System.out.println(1);
                    int total2 = 0;
                    for (int i = 0 ; i< listItem.size() ;i++){
                        total2 += (listItem.get(i).getProduct().getPrice() - (listItem.get(i).getProduct().getPrice() * listItem.get(i).getProduct().getDiscount()/ 100)) * listItem.get(i).getQuantity();
                    }
                    discountCode1.setStatus(1);
                    discountCode1.setTotal(total2);
                    return discountCode1;
                }else if(endDate.before(dataNow)){
                    System.out.println(2);
                    int total3 = 0;
                    for (int i = 0 ; i< listItem.size() ;i++){
                        total3 += (listItem.get(i).getProduct().getPrice() - (listItem.get(i).getProduct().getPrice() * listItem.get(i).getProduct().getDiscount()/ 100)) * listItem.get(i).getQuantity();
                    }
                    discountCode1.setStatus(2);
                    discountCode1.setTotal(total3);
                    return discountCode1;
                }
            }

            int total = (orderItem.getTotal() - ((orderItem.getTotal() * obj.getPercent())/100));
            System.out.println(orderItem.getTotal());
            System.out.println(((orderItem.getTotal() * obj.getPercent())/100));
            System.out.println(total);
            discountCode1.setStatus(3);
            discountCode1.setTotal(total);
        }else{

        }

//        orderItem.setTotal(total);
//        session.setAttribute("order", orderItem);
        return discountCode1;
    }

    @PostMapping("/order/{number}")
    public ModelAndView order(@PathVariable int number, HttpServletRequest request, RedirectAttributes rd){
        ModelAndView mv = new ModelAndView("redirect:/public/cart/index");
        String address = request.getParameter("address");
        String discountCode = request.getParameter("discountCode");
        System.out.println(discountCode);
        String phoneNumber = request.getParameter("phoneNumber");
        String note = request.getParameter("note");
        String methodPayment = request.getParameter("methodPayment");
        int methodPay = Integer.parseInt(methodPayment);
        HttpSession session = request.getSession();
        User checkAuth = middleware.middlewareUser(request);
        DiscountCode obj = discountCodeService.findDiscountCodeByCode(discountCode);
        if (checkAuth == null){
            rd.addFlashAttribute("user_login", messageSource.getMessage("user_login", null, Locale.getDefault()));
        } else {
            if(number == 0){
                OrderItem orderItem = (OrderItem) session.getAttribute("order");
                Order order = new Order();
                order.setAddress(address);
                order.setDescription(note);
                int amount =  orderItem.getTotal();
                System.out.println(orderItem.getTotal());
                System.out.println(amount);
                if(obj == null){
                    order.setAmount(orderItem.getTotal());
                }else {
                    int total1 = (orderItem.getTotal() - ((orderItem.getTotal() * obj.getPercent())/100));
                    order.setAmount(total1);
                }

                order.setPhoneNumber(phoneNumber);
                order.setStatus(1);
                order.setUser(checkAuth);
                order.setIsPayment(0);
                order.setMethodPayment(methodPay);
                order.setOrderDate(java.time.LocalDate.now().toString());
                orderService.save(order);

                for (int i =0 ; i< orderItem.getItemModels().size() ; i++){
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(orderItem.getItemModels().get(i).getProduct());
                    orderDetail.setDiscount(orderItem.getItemModels().get(i).getQuantity());
                    orderDetail.setUnitPrice((orderItem.getItemModels().get(i).getProduct().getPrice() - (orderItem.getItemModels().get(i).getProduct().getPrice() * orderItem.getItemModels().get(i).getProduct().getDiscount()/ 100)));
                    orderDetailService.save(orderDetail);
                    Product product = orderItem.getItemModels().get(i).getProduct();
                }

            }else{
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Product product = productService.getProductById(number);
                if(quantity > product.getQuantity()){
                    rd.addFlashAttribute("order_error","order_error" );
                    String url = "redirect:/public/cart/buy-now/"+number;
                    mv = new ModelAndView(url);
                    return mv;
                }
                Order order1 = new Order();
                order1.setAddress(address);
                order1.setDescription(note);
                order1.setAmount((product.getPrice() - (product.getPrice() * product.getDiscount()/ 100))+3);
                order1.setPhoneNumber(phoneNumber);
                order1.setStatus(1);
                order1.setUser(checkAuth);
                order1.setIsPayment(0);
                order1.setMethodPayment(methodPay);
                order1.setOrderDate(java.time.LocalDate.now().toString());
                orderService.save(order1);

                OrderDetail orderDetail1 = new OrderDetail();
                orderDetail1.setOrder(order1);
                orderDetail1.setProduct(product);
                orderDetail1.setDiscount(product.getDiscount());
                orderDetail1.setUnitPrice((product.getPrice() - (product.getPrice() * product.getDiscount()/ 100)));
                orderDetailService.save(orderDetail1);


            }
            List<Order> orderlast = orderService.orderLast();
            Order last = orderlast.get(0);
            if(methodPay == 1){
                rd.addFlashAttribute("order_success", messageSource.getMessage("order_success", null, Locale.getDefault()));
                session.setAttribute("order", null);
            }
            else if(methodPay == 2){
                session.setAttribute("order", null);
                String url = "redirect:/payment/" + last.getId();
                mv = new ModelAndView(url);
                return mv;
            }else if(methodPay == 3){
                session.setAttribute("order", null);
                String url = "redirect:/momo/" + last.getId();
                mv = new ModelAndView(url);
                return mv;
            }

        }
        return mv;
    }

    @PostMapping("buy-now/{id}")
    public ModelAndView buyNow(@PathVariable int id, HttpServletRequest request){
        Product product = productService.getProductById(id);
        ModelAndView mv = new ModelAndView("redirect:/public/cart/index");
//        mv.addObject("categories",categoryService.getAll());
//        mv.addObject("productBuyNow",product);
        return mv;
    }

    @GetMapping("buy-now/{id}")
    public ModelAndView buyNowGet(@PathVariable int id, HttpServletRequest request){
        Product product = productService.getProductById(id);
        ModelAndView mv = new ModelAndView("public/cart");
        mv.addObject("categories",categoryService.getAll());
        mv.addObject("productBuyNow",product);
        return mv;
    }
}
