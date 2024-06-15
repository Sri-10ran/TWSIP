<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("user_name");
    String aadhar = request.getParameter("aadhar");

    String mobile = request.getParameter("mob_no");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/voter", "root", "");
        stmt = con.createStatement();
        String sql = "SELECT * FROM people where aadhar="+aadhar;
        rs = stmt.executeQuery(sql);
        while(rs.next()) {
            // out.println("<tr><td>" + rs.getString(2) + "</td><td>" + rs.getString(7) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td></tr>");
            if(rs.getString(6).equals(aadhar) && rs.getString(8).equals("not_voted"))
            {
                response.sendRedirect("http://localhost:8080/voter/vote.jsp?aadhar="+aadhar);
            }
            else if(rs.getString(8).equals("voted")){
                 out.print("<script>alert('You are already voted, Thank You !')</script>");
                 out.print("<script>window.location.href='http://localhost:8080/voter/login.html'</script>");
                // response.sendRedirect("http://localhost:8080/voter/login.html");
            }
            else{
                response.sendRedirect("http://localhost:8080/voter/login.html"); 
            }
        }
    } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                response.getWriter().println("Error closing resources: " + e.getMessage());
            }
        }
        
%>
