<%@ page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.web.mypage.model.dto.WishList, java.util.List" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<WishList> list = (List)request.getAttribute("wishlist");
%>
<style>
        .mypage-heart-container{
        	display: flex;
        	flex-direction: column;
    		align-items: center;
    		height: auto;
    		
        }
        .item-container {
            width: 80%;
            margin: 0 auto;
            
        }
        .wishlist-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }
        .item-image {
            width: 120px;
            margin-right: 20px;
        }
        .item-image img {
            width: 100%;
            height: auto;
        }
        .item-details {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .item-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .item-option{
        	font-size: 14px;
            font-weight: bold;
            margin-bottom: 10px;
            font-style: italic;
            margin-left: 5%;
            width: 18%;
        }
        .item-title{
        display: flex;
	    
	    align-items: flex-end;
	    }
        .item-price {
            color: #f00;
            margin-bottom: 10px;
        }
        .item-actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-cart {
            background-color: #28a745;
            color: #fff;
        }
        .btn-remove {
            background-color: #dc3545;
            color: #fff;
        }
    </style>

<section class="content">
	<div class="mypage-heart-container">
		<h1 style="overflow:hidden; margin:4%; font-weight: bolder;">찜 리스트</h1>
		<%if(list!=null && list.size()>0){ %>
		<div style="display: flex; justify-content: flex-end; width: 80%;">
			<button id="deleteallbtn" class="btn btn-remove">선택한 상품삭제</button>
		</div>
		<%} %>
		<%if(list!=null && list.size()>0){ %>
			<% for(WishList l : list){  %>
		<div class="item-container">
	        <div class="wishlist-item">
	            <div class="item-image">
	                <img src="<%=request.getContextPath() %>/images/shoppingmall/product/<%=l.getProductImg() %>" 
	                	alt="상품 1 이미지">
	            </div>
	            <div class="item-details">
	            	<div class="item-title">
		                <div class="item-name"><%=l.getProductName() %></div>
		                <% if(l.getProductSize()!=null || l.getProductColor()!=null){ %>
		                <div class="item-option">
		                 선택하신 옵션 : <%=l.getProductSize() != null? l.getProductSize()+" " :""%><%=l.getProductColor()!=null?l.getProductColor():""%>
		                </div>
		                <%} %>
	                </div>
	                <div class="item-price"><%=(int)((100-l.getRateDiscount())/100*l.getPrice()) %>원</div>
	                <div class="item-actions">
	                	<input type="hidden" name="wishlistkey" value=<%=l.getWishListKey()%>>
	                	<input type="hidden" name="productkey" value=<%=l.getProductKey()%>>
	                	<input type="hidden" name="productcolor" value=<%=l.getProductColor()%>>
	                	<input type="hidden" name="productsize" value=<%=l.getProductSize()%>>
	                    <button class="btn btn-cart" value=<%=l.getWishListKey()%>>장바구니에 담기</button>
	                    <button class="btn btn-remove" value=<%=l.getWishListKey() %>>삭제</button>
	                </div>
	                
	            </div>
	            <div>
	            	<input class="checkItem" type="checkbox" value=<%=l.getWishListKey() %>> 	
	            </div>
	        </div>
	    </div>
	    	<%}%>
		<% }else { %>
	    	<h1 style="overflow: hidden; margin-bottom:4%;">찜 하신 상품이 없습니다.</h1>
	    	<button class="btn btn-cart" onclick="location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=1')">상품 페이지로 이동하기</button>
	    <%} %>
    </div>
    <%if(list!=null && list.size()>0){ %>
    <div style="margin: 4%;">
	    <%=request.getAttribute("pageBar")%>
	</div>
	<%} %>
</section>
	
<script>
	window.onload = () => {
		$(".btn-remove").click(e=>{			
			location.assign("<%=request.getContextPath()%>/user/wishlistdelete.do?targetItems="+e.target.value);
		})
		
		$("#deleteallbtn").click(e=>{
			let targetItems="";
			if($(".checkItem:checked").length!=0){
				$(".checkItem:checked").each((i,v) =>{
					/* console.log(i+"번째는 "+v.value);  */
					if(i!=$(".checkItem:checked").length-1){
						targetItems+=v.value+",";	
					} else {
						targetItems+=v.value;
					}
				})
				/* console.dir(targetItems); */
				location.assign("<%=request.getContextPath()%>/user/wishlistdelete.do?targetItems="+targetItems);
			} else {
				alert('선택하신 상품이 없습니다.');
			}
		})
		
		$(".btn-cart").click(e=>{
			let wishlist = "";
			const $inputs = e.target.parentElement.querySelectorAll('input');
			$inputs.forEach((i,o)=>{
				if(o!=$inputs.length-1){
					wishlist=wishlist+i.name+"="+i.value+"&";
				} else {
					wishlist=wishlist+i.name+"="+i.value;
				}
			})
			console.log(wishlist);
			location.assign("<%=request.getContextPath()%>/user/movetocart.do?"+wishlist);
		})
	}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>