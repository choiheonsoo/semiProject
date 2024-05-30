<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.shoppingmall.model.dto.Orders, com.web.shoppingmall.model.dto.Product,
				 java.util.Map, com.web.shoppingmall.model.dto.Review" %>
<%
	List<Orders> orders=(List<Orders>)request.getAttribute("orders");
	Map<String, Product> products=(Map<String, Product>)request.getAttribute("products");
	List<Review> reviews=(List<Review>)request.getAttribute("reviews");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/orderlist.css">
<section class="orderlistSection content">
	<div class="orderlist">
		<%if(!orders.isEmpty()){ %>
			<%for(Orders o: orders){ %>
		<div class="orderContainer">
			<div class="orderDate">
				<span><%=o.getShippingDate() %></span> 주문
			</div>
			<div class="pcontent">
				<div class="productDiv">
					<div class="status">
					<%=o.getShippingStatus() %>
					</div>
					<div class="productcontent">
						<div class="pimg">
							<img src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductCategory().getProductCategoryName() %>/<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductImgs().get("thumbnail").getProductImg()%>">
						</div>
						<div>
							<div class="pname">
								<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductName() %>
								<%if(o.getOrderDetails().size()>1){ %>
									, 외 <%=o.getOrderDetails().size() %>건
								<%} %>
							</div>
							<div class="pprice"><%=o.getShippingPrice() %>원</div>
						</div>
					</div>
				</div>
				<div class="btnDiv">
					<%if(reviews.isEmpty()){ %>
						<input type="hidden" value="<%=o.getOrderDetails().get(0).getProductKey()%>" id="pk">
						<button class="reviewBtn">리뷰 작성하기</button>
					<%}else{ %>
						<%if(!reviews.stream().anyMatch(e->e.getProductKey()==o.getOrderDetails().get(0).getProductKey())){%>
							
							<input type="hidden" value="<%=o.getOrderDetails().get(0).getProductKey()%>" id="pk">
							<button class="reviewBtn">리뷰 작성하기</button>
							
						<%} %>
					<%} %>
				</div>
			</div>
		</div>
			<%} %>
		<%}else{ %>
			주문한 상품이 없습니다.
		<%} %>
	</div>
	<div class="reviewmodalContainer modalhidden">
		<div class="reviewheaddiv">
			<div class="modalhead">
				<h2 class="rtext">리뷰쓰기</h2>
				<h2 class="reviewmodalclosebtn">x</h2>
			</div>
				<div class="filediv">
					리뷰 이미지등록 <input type="file" name="files" id="fileInput" multiple accept="image/*">
					별점
					<select id="rating">
   						<option value="5">5</option>
						<option value="4">4</option>
						<option value="3">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select>
				</div>
				<div class="reviewcontentdiv">
					<div class="contenthead">
						<span>리뷰내용</span>
					</div>
					<div class="reviewtextdiv">
						<textarea name="content" class="reviewtextarea"></textarea>
					</div>
				</div>
				<div class="reviewbtndiv">
					<button class="reviewEnrollbtn" id="reviewEnrollbtn">리뷰 등록하기</button>
				</div>	
		</div>
	</div>
</section>
<script>
	$(".reviewBtn").click(e=>{
		$(".reviewmodalContainer").removeClass("modalhidden");
	});
	$(".reviewEnrollbtn").click(e=>{
		const content=$(".reviewtextarea").val();
		if(!content){
			e.preventDefault();
			alert("리뷰내용을 반드시 작성해주세요.");
		}else{
			const userId='<%=loginUser.getUserId()%>';
			const productKey=parseInt($("#pk").val());
			const rating=$("#rating").val();
			const form=new FormData();
			const files=$("#fileInput")[0].files;
			console.log($("#fileInput"));
			for(let i=0;i<files.length;i++){
				form.append("files"+i,files[i]);
			}
			form.append("content",content);
			form.append("userId",userId);
			form.append("productKey",productKey);
			form.append("rating",rating);
			$.ajax({
				url:"<%=request.getContextPath()%>/shoppingmall/enrollreview.do",
				data:form,
				type:"POST",
				processData:false,
				contentType:false,
				success:data=>{
					const responseData=JSON.parse(data);
					if(responseData.result){
						alert("업로드 성공!");
						location.reload();
					}else{
						alert("업로드 실패!");
					}
				},
				complete:()=>{
					$("#fileInput").val("");
					$(".reviewtextarea").val("");
				}
			});
		}
	});
	$(".reviewmodalclosebtn").click(e=>{
		$(".reviewmodalContainer").addClass("modalhidden");
	});
	
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>