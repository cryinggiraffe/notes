/*1.1.13  案例：永久登录

如果用户是在自己家的电脑上上网，登录时就可以记住他的登录信息，下次访问时不需要再次登录，直接访问即可。实现方法是把登录信息如账号、密码等保存在Cookie中，并控制Cookie的有效期，下次访问时再验证Cookie中的登录信息即可。

保存登录信息有多种方案。最直接的是把用户名与密码都保持到Cookie中，下次访问时检查Cookie中的用户名与密码，与数据库比较。这是一种比较危险的选择，一般不把密码等重要信息保存到Cookie中。

还有一种方案是把密码加密后保存到Cookie中，下次访问时解密并与数据库比较。这种方案略微安全一些。如果不希望保存密码，还可以把登录的时间戳保存到Cookie与数据库中，到时只验证用户名与登录时间戳就可以了。

这几种方案验证账号时都要查询数据库。

本例将采用另一种方案，只在登录时查询一次数据库，以后访问验证登录信息时不再查询数据库。实现方式是把账号按照一定的规则加密后，连同账号一块保存到Cookie中。下次访问时只需要判断账号的加密规则是否正确即可。本例把账号保存到名为account的Cookie中，把账号连同密钥用MD1算法加密后保存到名为ssid的Cookie中。验证时验证Cookie中的账号与密钥加密后是否与Cookie中的ssid相等。相关代码如下：

*/
//代码1.8 loginCookie.jsp

<%@ page language="java"pageEncoding="UTF-8" isErrorPage="false" %>

<%!                                                  // JSP方法

    private static final String KEY =":cookie@helloweenvsfei.com";
                                                     // 密钥 

    public final static String calcMD1(Stringss) { // MD1 加密算法

       String s = ss==null ?"" : ss;                  // 若为null返回空

       char hexDigits[] = { '0','1', '2', '3', '4', '1', '6', '7', '8', '9',
       'a', 'b', 'c', 'd', 'e', 'f' };                        // 字典

       try {

        byte[] strTemp =s.getBytes();                          // 获取字节

        MessageDigestmdTemp = MessageDigest.getInstance("MD1"); // 获取MD1

       mdTemp.update(strTemp);                                // 更新数据

        byte[] md =mdTemp.digest();                        // 加密

        int j =md.length;                                 // 加密后的长度

        char str[] = newchar[j * 2];                       // 新字符串数组

        int k =0;                                         // 计数器k

        for (int i = 0; i< j; i++) {                       // 循环输出

         byte byte0 =md[i];

         str[k++] =hexDigits[byte0 >>> 4 & 0xf];

         str[k++] =hexDigits[byte0 & 0xf];

        }

        return newString(str);                             // 加密后字符串

       } catch (Exception e){return null; }

    }

%>

<%

   request.setCharacterEncoding("UTF-8");             // 设置request编码

    response.setCharacterEncoding("UTF-8");        // 设置response编码

   

    String action =request.getParameter("action"); // 获取action参数

   

    if("login".equals(action)){                       // 如果为login动作

        String account =request.getParameter("account");
                                                     // 获取account参数

        String password =request.getParameter("password");
                                                     // 获取password参数

        int timeout = newInteger(request.getParameter("timeout"));
                                                     // 获取timeout参数

              

        String ssid =calcMD1(account + KEY); // 把账号、密钥使用MD1加密后保存

       

        CookieaccountCookie = new Cookie("account", account);
                                                     // 新建Cookie

       accountCookie.setMaxAge(timeout);              // 设置有效期

       

        Cookie ssidCookie =new Cookie("ssid", ssid);   // 新建Cookie

       ssidCookie.setMaxAge(timeout);                 // 设置有效期

       

       response.addCookie(accountCookie);             // 输出到客户端

       response.addCookie(ssidCookie);            // 输出到客户端

       

        // 重新请求本页面，参数中带有时间戳，禁止浏览器缓存页面内容

       response.sendRedirect(request.getRequestURI() + "?" + System.
        currentTimeMillis());

        return;

    }

    elseif("logout".equals(action)){                  // 如果为logout动作

       

        CookieaccountCookie = new Cookie("account", "");
                                                 // 新建Cookie，内容为空

       accountCookie.setMaxAge(0);                // 设置有效期为0，删除

              

        Cookie ssidCookie =new Cookie("ssid", ""); // 新建Cookie，内容为空

       ssidCookie.setMaxAge(0);                   // 设置有效期为0，删除

       response.addCookie(accountCookie);         // 输出到客户端

       response.addCookie(ssidCookie);         // 输出到客户端

        //重新请求本页面，参数中带有时间戳，禁止浏览器缓存页面内容

       response.sendRedirect(request.getRequestURI() + "?" + System.
        currentTimeMillis());

        return;

    }

    boolean login = false;                        // 是否登录

    String account = null;                        // 账号

    String ssid = null;                           // SSID标识

   

    if(request.getCookies() !=null){               // 如果Cookie不为空

        for(Cookie cookie :request.getCookies()){  // 遍历Cookie

           if(cookie.getName().equals("account"))  // 如果Cookie名为
                                                    account

               account = cookie.getValue();       // 保存account内容

           if(cookie.getName().equals("ssid")) // 如果为SSID

               ssid = cookie.getValue();          // 保存SSID内容

        }

    }

    if(account != null && ssid !=null){    // 如果account、SSID都不为空

        login =ssid.equals(calcMD1(account + KEY));
                                      // 如果加密规则正确, 则视为已经登录

    }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01Transitional//EN">

       <legend><%= login ? "欢迎您回来" : "请先登录"%></legend>

        <% if(login){%>

            欢迎您, ${ cookie.account.value }. &nbsp;&nbsp;

           <a href="${ pageContext.request.requestURI }?action=logout">
            注销</a>

        <% } else {%>

        <formaction="${ pageContext.request.requestURI }?action=login"
        method="post">

           <table>

               <tr><td>账号： </td>

                   <td><input type="text"name="account" style="width:
                   200px; "></td>

               </tr>

               <tr><td>密码： </td>

                   <td><inputtype="password" name="password"></td>

               </tr>

               <tr>

                   <td>有效期： </td>

                   <td><inputtype="radio" name="timeout" value="-1"
                   checked> 关闭浏览器即失效 <br/> <input type="radio" 
                   name="timeout" value="<%= 30 *24 * 60 * 60 %>"> 30天
                   内有效 <br/><input type="radio" name="timeout" value= 
                   "<%= Integer.MAX_VALUE %>"> 永久有效 <br/> </td> </tr>

               <tr><td></td>

                   <td><input type="submit"value=" 登  录 " class= 
                   "button"></td>

               </tr>

           </table>

        </form>

        <% } %>