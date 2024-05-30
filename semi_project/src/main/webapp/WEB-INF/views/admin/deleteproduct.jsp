<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.admin.product.dto.AddProduct" %>
<%
	List<AddProduct> products = (List<AddProduct>)request.getAttribute("products");
	// 	out.print(products);
%>
    <section class="product-delete-container">
        <div class="product-delete-category-select">
            <label for="product-delete-category">카테고리 선택:</label>
            <select id="product-delete-category" name="category">
                <option value="1">사료</option>
                <option value="2">간식</option>
                <option value="3">배변패드</option>
                <option value="4">의류</option>
                <option value="5">목욕용품</option>
                <option value="6">미용용품</option>
                <option value="7">하네스/리드줄</option>
                <option value="8">기타</option>
            </select>
        </div>
        <div id="product-delete-list" class="product-delete-list">
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
        </div>
        <div>
	       <%=request.getAttribute("pageBar") %>
	    </div>   
        
    </section>