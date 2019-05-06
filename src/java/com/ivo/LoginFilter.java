/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ivo;

import com.ivo.ejb.LibraryStatefulBeanRemote;
import com.ivo.ejb.LibraryStatelessBeanRemote;
import com.ivo.entities.Book;
import com.ivo.entities.Cart;
import com.ivo.entities.Uza;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author benhur
 */
public class LoginFilter implements Filter {
    
    private static final boolean debug = false;

    private FilterConfig filterConfig = null;
    
    Properties props;
    InitialContext ctx;
    LibraryStatelessBeanRemote adm = null;
    LibraryStatefulBeanRemote usa = null;   
 
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        try{
                                        
          HttpServletRequest req = (HttpServletRequest) request;
          HttpSession session = req.getSession(false);
          
          
          Cart cc = new Cart();
          if(null!=session){
              System.out.println("in session");
                Map<String,String[]> parm = request.getParameterMap();
          
            if(parm.size()>0){
                
                
                Properties jndiProps = new Properties();
            jndiProps.put(Context.INITIAL_CONTEXT_FACTORY,
                    "org.jboss.naming.remote.client.InitialContextFactory");
            System.out.println("hahaha");
            jndiProps.put(Context.INITIAL_CONTEXT_FACTORY,
                    "org.jboss.naming.remote.client.InitialContextFactory");
            
            jndiProps.put(Context.PROVIDER_URL, "http-remoting://127.0.0.1:8080");
            jndiProps.put("jboss.naming.client.ejb.context", true);
            
            ctx = new InitialContext(jndiProps); 
            adm = (LibraryStatelessBeanRemote)
                    ctx.lookup("bookshop/LibraryStatelessBean!com.ivo.ejb.LibraryStatelessBeanRemote");
            usa = (LibraryStatefulBeanRemote) 
                    ctx.lookup("bookshop/LibraryStatefulBean!com.ivo.ejb.LibraryStatefulBeanRemote");

          
            Uza uz=null;
                if(null!=session.getAttribute("uz")){
                uz = (Uza)session.getAttribute("uz");
                
                if(req.getRequestURI().equals("/addBook")){
                    
                String title = request.getParameter("tit").trim();
                
                int price = Integer.parseInt(request.getParameter("pri").trim());
                if(title.length()>0)
                adm.addBook(uz.getPwd(), title, price);
                }
                else 
                    
                    if(req.getRequestURI().equals("/viewBook")){
             request.getRequestDispatcher("/viewBook.jsp").forward(request, response);       
                }
                    
                    
                else if(req.getRequestURI().equals("/addCart")){
                    System.out.println("ha b4");
                    cc.setUid(uz.getUid());
                    System.out.println("ha after");
                    int cnt=Integer.parseInt(request.getParameter("arSize").trim());
                    System.out.println("ar "+cnt);
                    if(cnt>0){
                        List<Book> bks = new ArrayList<>();
                    for(int i=1;i<=cnt;i++){
                        int bid = 0;
                        if(null!=request.getParameter("c"+cnt)){
                  bid=Integer.parseInt(request.getParameter("c"+cnt).trim());
                            System.out.println("bid "+bid);
                    Book b = adm.getBook(bid);
                            System.out.println("bk "+b.getTitle());
                            if(!bks.contains(b)){
                    bks.add(b);
                    usa.addToCart(cc, bid);
                            }
                        }
                    }
                    session.setAttribute("crt", bks);
                    }
             request.getRequestDispatcher("/viewCart.jsp").forward(request, response);       
                }
                else if(req.getRequestURI().equals("/viewCart")){
             request.getRequestDispatcher("/viewCart.jsp").forward(request, response);       
                }
                else if(req.getRequestURI().equals("/buy")){
                    usa.buy(cc);
                    session.removeAttribute("crt");
             request.getRequestDispatcher("/user.jsp").forward(request, response);       
                }
                }
                else{
             //   String ad_bk = request.getParameter("ad_bk").trim();
            String un = request.getParameter("un").trim();
            String pw = request.getParameter("pw").trim();
                System.out.println("awww "+un+" "+pw);
                uz = adm.login(un, pw);
                }
//                System.out.println("admmm "+uz.getUname());
                if (uz.getUid() == null) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
                } else {
                    session.setAttribute("uz", uz);
                    if (uz.getUtyp().equals("admin")) {
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
                    } else if(uz.getUtyp().equals("user")){
            request.getRequestDispatcher("/user.jsp").forward(request, response);
                    }
                    else{
         request.getRequestDispatcher("/index.jsp").forward(request, response); 
                    }
                }
            }
        else
            request.getRequestDispatcher("/index.jsp").forward(request, response);
          }
          else{
             request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
          
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                System.out.println("LoginFilter: Initializing filter");
            }
        }
    }
 
}
