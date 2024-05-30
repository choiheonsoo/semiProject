<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List, com.web.admin.product.dto.AddProduct" %>

		<table>
            	<tr>
            		<th>구분</th>
            		<th>브랜드</th>
            		<th>상품명</th>
            		<th>가격</th>
            		<th>할인율</th>
            		<th>삭제</th>
            	</tr>
            	<% String category = "";
            		for(AddProduct p : products){ %>
            	<tr>
            		<td>
            		<% switch(p.getCategory()){ 
	            		case 1: category="사료"; break;
	            		case 2: category="간식"; break;
	            		case 3: category="배변패드"; break;
	            		case 4: category="의류"; break;
	            		case 5: category="목욕용품"; break;
	            		case 6: category="미용용품"; break;
	            		case 7: category="하네스/리드줄"; break;
	            		case 8: category="기타"; break;
	            		default: category="잘못된 분류"; break;
            		}%>
            		<%=category %>
            		</td>
            		<td><%=p.getCategory() %></td>
            		<td><%=p.getProductName() %></td>
            		<td><%=p.getPrice() %></td>
            		<td><%=p.getDiscount() %></td>
            		<td><button class="deleteProductBtn" value="<%=p.getProductKey()%>">삭제</button></td>
            	</tr>
            	<%} %>
            </table>
            <div>
	        	<%=request.getAttribute("pageBar") %>
	        </div> --%>