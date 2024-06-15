
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String party = request.getParameter("party");
    String personId = request.getParameter("person_id");
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement updatePstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/voter", "root", "");

        // Insert into party table
        String insertSql = "INSERT INTO party (party_name) VALUES (?)";
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, party);
        int rows = pstmt.executeUpdate();
        pstmt.close(); // Close pstmt after the first query execution

        // Update status in people table
        String updateSql = "UPDATE people SET status = 'voted' WHERE id = (?)";
        updatePstmt = conn.prepareStatement(updateSql);
        updatePstmt.setString(1, personId);
        int updateRows = updatePstmt.executeUpdate();

        if (rows > 0 && updateRows > 0) {
            out.println("<script>alert('Thank you for voting!')</script>");
            out.println("<script>window.location.href='http://localhost:8080/voter/login.html'</script>");
            // response.sendRedirect("http://localhost:8080/voter/login.html");
        } else {
            out.println("<script>alert('Vote submission failed, please try again.')</script>");
            out.println("<script>window.location.href='http://localhost:8080/voter/vote.jsp'</script>");
            // response.sendRedirect("http://localhost:8080/voter/vote.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (updatePstmt != null) updatePstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>