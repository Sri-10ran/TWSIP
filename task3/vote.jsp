<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Layout</title>
    <style>
        html {
            scroll-behavior: smooth;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #FF9933, white, #138808); /* India's tricolor */
        }
        .page {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            width: 90%;
            max-width: 1000px; /* Adjusted width */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.2); 
            backdrop-filter: blur(10px); 
            -webkit-backdrop-filter: blur(10px); 
            border-radius: 15px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.3); 
            padding: 20px;
        }
        .section {
            padding: 20px;
            color: #333; 
            background: rgba(255, 255, 255, 0.7); 
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
        }
        .left {
            background: cornflowerblue; 
        }
        .right {
            background: rgba(19, 136, 8, 0.9); 
        }
        .section h1 {
            margin-bottom: 20px;
            color: white;
        }
        .profile-details {
            display: flex;
            flex-direction: column;
            align-items: flex-start; 
            color: white; 
            font-size: 18.3px; 
            line-height: 1.8; 
            margin: 0;
            padding: 0;
            font-weight: 580;
        }
        .profile-details span {
            margin-top: 4px; 
        }
        .right button {
            display: inline-block;
            width: auto;
            padding: 10px 20px;
            margin: 0;
            color: rgba(19, 136, 8, 0.9); 
            background-color: white; 
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .right button:hover {
            background-color: #f0f0f0; 
        }
        .rows {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0;
            gap: 10px; 
        }
        .rows h2 {
            margin: 0;
            flex: 1;
        }
        .rows h2 pre {
            display: inline; 
            color: white; 
            margin: 0; 
            padding: 0; 
        }
        .rows mark {
            background: white; 
            color: rgba(19, 136, 8, 0.9);
            padding: 2px 4px;
            border-radius: 3px;
            font-weight: bold;
        }
        @media (min-width: 800px) 
            .page {
                grid-template-columns: 1fr 1fr; 
                align-items: start; 
            }
            .left, .right {
                border-radius: 10px; 
                height: auto;
            }
        }
    </style>
</head>
<body>
    <div class="page">
        <div class="section left">
            <h1>Your Details</h1>
            <div class="profile-details">
    <%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String aadhar=request.getParameter("aadhar");
    int id=0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/voter", "root", "");
        stmt = con.createStatement();
        String sql = "SELECT * FROM people where aadhar="+aadhar;
        rs = stmt.executeQuery(sql);
        while(rs.next()) {
            // out.println("<tr><td>" + rs.getInt(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td></tr>");
            id=rs.getInt(1);
            out.println("<span>Name: "+ rs.getString(2)+"</span>");
            out.println("<span>City: "+ rs.getString(3)+"</span>");
            out.println("<span>State: "+ rs.getString(4)+"</span>");
            out.println("<span>Pincode: "+ rs.getString(5)+"</span>");
            out.println("<span>Status: "+ rs.getString(8)+"</span>"); 
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
            </div>
        </div>
        <div class="section right">
        <h1>Candidates of Your Locality</h1>
        <div class="rows">
            <h2><pre><span>Atchaya - </span> <mark>SRTUI</mark></pre></h2>
            <form action="vote1.jsp" method="post">
                <input type="hidden" name="party" value="SRTUI">
                <input type="hidden" name="person_id" value="<%= id %>"> 
                <button type="submit">Vote</button>
            </form>
        </div>
        <div class="rows">
            <h2><pre><span>Bathran    - </span> <mark>ABCDE</mark></pre></h2>
            <form action="vote1.jsp" method="post">
                <input type="hidden" name="party" value="ABCDE">
                <input type="hidden" name="person_id" value="<%= id %>"> 
                <button type="submit">Vote</button>
            </form>
        </div>
        <div class="rows">
            <h2><pre><span>Nani    - </span> <mark>YWDF</mark></pre></h2>
           <form action="vote1.jsp" method="post">
                <input type="hidden" name="party" value="YWDF">
                <input type="hidden" name="person_id" value="<%= id %>"> 
                <button type="submit">Vote</button>
            </form>
        </div>
        <div class="rows">
            <h2><pre><span>Sid Ram - </span> <mark>KMLN</mark></pre></h2>
            <form action="vote1.jsp" method="post">
                <input type="hidden" name="party" value="KMLN">
                <input type="hidden" name="person_id" value="<%= id %>"> 
                <button type="submit">Vote</button>
            </form>
        </div>
    </div>    </div>
</body>
</html>
