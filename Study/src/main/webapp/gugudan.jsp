<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="EUC-KR">
        <title>Insert title here</title>
        <style>
            table {
                border: 1px solid goldenrod;
                border-collapse: collapse;
            }

            td:hover {
                background-color: bisque;
            }
        </style>
    </head>

    <body>
        <%  out.println("<div><h1>구구단 표</h1></div>");

            out.println("<table class='tbl-ex'>");
                out.println("<tr>");

                    for(int i=2; i<10; i++){ out.println("<th>" + i + "단</th>" );
                        }
                        out.println("</tr>");

                out.println("<tr>");
                    for(int i=2; i<10; i++){ out.println("<td>" );
                        for(int j=1; j<10; j++){ out.println(i + " * " + j + " = " + i*j + "<br>" ); }
                            out.println("</td>" );
                            }
                            out.println("</tr>");
                out.println("</table>");
            %>
    </body>

    </html>