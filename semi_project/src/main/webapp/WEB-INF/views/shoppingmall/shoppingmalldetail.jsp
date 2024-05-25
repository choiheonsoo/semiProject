<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.web.shoppingmall.model.dto.Product,java.util.Map,com.web.shoppingmall.model.dto.ProductImg,
				 com.web.shoppingmall.model.dto.ProductOption,java.util.HashMap,java.util.ArrayList,java.util.Set,
				 com.web.user.model.dto.User, com.web.shoppingmall.model.dto.Review, com.web.shoppingmall.model.dto.ReviewImg,
				 com.web.shoppingmall.model.dto.Qna, com.web.shoppingmall.model.dto.QnaAnswer" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	/* DecimalFormat df=new DecimalFormat("#,###"); */
	Product p=(Product)request.getAttribute("product");
	String r=(String)request.getAttribute("r");
	String pageBar=(String)request.getAttribute("pageBar");
	String imgName=null;
	List<Map<String, String>> options=new ArrayList<>();
	List<User> users=(List<User>)request.getAttribute("user");
	boolean first=true;
	if(p.getProductOption()!=null){
		for(ProductOption po:p.getProductOption()){
			//Map<size, color>
			Map<String, String> m=new HashMap<>(); 
			if(po.getColor().getColor()!=null&&po.getProductSize().getPSize()!=null){
				m.put(po.getProductSize().getPSize(),po.getColor().getColor());
				options.add(m);
			}else if(po.getColor().getColor()==null&&po.getProductSize().getPSize()!=null){
				m.put(po.getProductSize().getPSize(),"NULL");
				options.add(m);
			}else if(po.getColor().getColor()!=null&&po.getProductSize().getPSize()==null){
				m.put("NULL",po.getColor().getColor());
				options.add(m);
			}
		}
	}
	List<Qna> qnas=(List<Qna>)request.getAttribute("qna");
	String qnaPageBar=(String)request.getAttribute("qnaPageBar");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shoppingmall/shoppingmalldetail.css">
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<!-- 포트원 결제 -->
<section>
	<div class="detailContainer">
		<div>
			<div class="productImg">
				<img class="mainProductImg" alt="" src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=p.getProductImgs().get("thumbnail").getProductImg()%>">
				<%for (Map.Entry<String, ProductImg> entry : p.getProductImgs().entrySet()) {
					if(!entry.getKey().equals("description")){
						imgName=entry.getValue().getProductImg();%>
						<div class="imgbordercontainer">
							<img class="productImgs" alt="" src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=imgName%>">
							<i class="iborder"></i>
						</div>
					<%} %>
				<% }%>
			</div>
			<div class="purchase">
				<div>
					<div class="name">
						<span><%=p.getProductName() %></span>
					</div>
					<div class="price">
						<span class="discountRate"><%=p.getRateDiscount() %></span>
						<span class="cost"><%=p.getPrice() %></span>
						<span class="salePrices"><%=p.getPrice()*(100-p.getRateDiscount())/100 %>원</span>
					</div>
					<div class="quantity">
						<button onclick='minus()'>-</button>
						<span class="purchaseQuantity" id="purchaseQuantity">1</span>
						<button onclick='plus()'>+</button>
						<span class="stockalarm"></span>
					</div>
					<div class="totalPrice">
						<span>총 결제가격 : <span class="totalPrice" id="totalPrice"><%=p.getPrice()*(100-p.getRateDiscount())/100 %></span>원</span> 
					</div>
					<div class="purchaseButton">
						<button onclick="movePaypage()">구매</button> <!-- 구매버튼 누르면 구매 페이지로 가야함 -->
						<button onclick="">장바구니 담기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="starReviewContainer">
		<div class="starContainer">
			<div>
				<span>사용자 총 평점</span>
			</div>
			<div class="stars">
				<%for(int i=0;i<5;i++){ %>
					<%if(i<Math.floor(p.getAvgRating())){ %>
						<div class="star full-star"></div>
					<%}else if(i==Math.floor(p.getAvgRating())){ %>
						<%if(p.getAvgRating()-Math.floor(p.getAvgRating())>0.5){ %>
							<div class="star full-star"></div>
						<%}else if(p.getAvgRating()-Math.floor(p.getAvgRating())>0){ %>
							<div class="star half-star"></div>
						<%}else{ %>
	        				<div class="star empty-star"></div>
	        			<%} %>
	        		<%}else{ %>
	        			<div class="star empty-star"></div>
	        		<%} %>
        		<%} %>
			</div>
			<div>
				<span><%=Math.round(p.getAvgRating() * 10.0) / 10.0%></span>
			</div>
		</div>
		<div class="reviews">
			<span>전체 리뷰 수</span>
			<span class="reviewCount"><%=p.getTotalReviewCount() %></span>
		</div>
	</div>
	<div class="moveMenuContainer">
		<div class="moveMenuWidth">
			<ul class="moveMenu">
				<li id="moveDetail">상세설명</li>
				<li id="moveReview">리뷰</li>
				<li id="moveQna">Q&A</li>
			</ul>
		</div>
	</div>
	<div class="detailImgContainer">
		<div class="detailImg">
			<%if(p.getProductImgs().containsKey("description")){ %>
			<div class="imgborder foldingoption">
			<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=p.getProductImgs().get("description").getProductImg() %>" alt="상세설명이미지">
			</div>
			<%} %>
			<button class="folding">
				펼치기
			</button>
		</div>
	</div>
	<div class="reviewContainer">
		<div>
			<span>전체 리뷰</span>
			<div class="reviewSortMenu">
				<button class="datesort selectedReviewSortbtn">최신순</button>
				<div>|</div>
				<button class="ratingsort">별점순</button>
			</div>
			<%if(!users.isEmpty()){ %>
				<%for(User u:users){ %>
					<div class="reviewBox">
						<div class="reviewWriter">
							<div class="reviewWriterImg">
									<%if(u.getDog().get(0).getDogImg()!=null){ %>
									<img 
									src="<%=request.getContextPath() %>/upload/user/<%=u.getDog().get(0).getDogImg()%>" 
									alt="프로필">
									<%}else{ %>
										<img src="<%=request.getContextPath() %>/images/user.png" alt="프로필">
									<%} %>
							</div>
							<div>
								<span class="memberName"><%=u.getUserId() %></span>
								<span class="reviewDate"><%=u.getReviews().get(0).getReviewDate() %></span>
								<div class="stars">
									<%for(int i=0;i<5;i++){ %>
										<%if(i<u.getReviews().get(0).getRating()){ %>
											<div class="star full-star"></div>
						        		<%}else{ %>
						        			<div class="star empty-star"></div>
						        		<%} %>
					        		<%} %>
								</div>
							</div>
						</div>
						<div class="reviewImgs">
							<%for(Review re:u.getReviews()){ %>
								<%for(ReviewImg ri:re.getReviewImgs()){ %>
									<%if(ri.getReviewImg()!=null){ %>
										<img src="<%=request.getContextPath() %>/upload/shoppingmall/review/<%=ri.getReviewImg() %>" alt="리뷰이미지">
									<%} %>
								<%} %>
							<%} %>
						</div>
						<div class="reviewContent">
							<span><%=u.getReviews().get(0).getReviewContent()%></span>
						</div>
					</div>
				<%} %>
			<%}else{ %>
				<h3>리뷰가 없습니다.</h3>
			<%} %>
		</div>
	</div>
	<div class="pagebardiv">
		<%=pageBar %>
	</div>
	<div class="qnaContainer">
		<div class="qnaPostContainer">
			<div class="qnaHead">
				<span class="qnaText">Q&A</span>
				<button class="enrollQna">문의하기</button>
			</div>
			<div class="qnaBox">
			<%if(qnas!=null){ %>
				<%for(Qna q: qnas){ %>
					<div class="qnaPostBox">
						<div class="qnaTitle">
							<div class="qnatag">
								질문
							</div>
							<div class="qnaContent">
								<%=q.getQnaContent() %>
							</div>
						</div>
						<div class="qnadate">
						<%if(loginUser!=null){%>
						<%if(q.getUserId().equals(loginUser.getUserId())){ %>
							<div>
								<input type="hidden" value="<%=q.getQnaKey()%>" class="qk">
								<button class="qnaupdatebtn">수정</button>
								|
								<button class="qnadeletebtn">삭제</button>
							</div>
						<%} %>
						<%} %>
							<span><%=q.getQnaDate() %></span>
						</div>
					</div>
					<%if(q.getAnswer().getQnaAnswerKey()!=0){ %>
					<div class="qnaAnswerBox">
						<div class="qnaTitle">
							<div class="arrow">
								<img src="<%=request.getContextPath()%>/images/shoppingmall/down-right-arrow.png">
							</div>
							<div class="answertag">
								답변
							</div>
							<div class="qnaContent">
								<%=q.getAnswer().getQnaAnswerContent() %>
							</div>
						</div>
						<div class="qnadate">
							<span><%=q.getAnswer().getQnaAnswerDate() %></span>
						</div>
					</div>
					<%} %>
				<%} %>
			<%} %>
			</div>
		</div>
	</div>
	<div class="qnapagebarContainer">
		<%=qnaPageBar %>
	</div>
	<button class="topbtn tophidden">
		top
	</button>
</section>
	<!-- 리뷰 이미지 모달창 -->
	<div class="modalContainer modalhidden">
		<div class="modalContent">
			<button class="modalclosebtn">x</button>
			<button class="modalleftbtn"><</button>
			<button class="modalrightbtn">></button>
			<div class="modalimgdiv">
				<div class="modalmainimgdiv">
					<img class="modalmainimg">
				</div>
				<div class="modalallimgsdiv"></div>
			</div>
		</div>
	</div>
	<!-- 문의 등록하기 모달창 -->
	<div class="qnamodalContainer qnamodalhidden">
		<div class="qnaheaddiv">
			<div class="modalhead">
				<h2 class="qtext">문의하기</h2>
				<h2 class="qnamodalclosebtn">x</h2>
			</div>
			<div class="qnacontentdiv">
				<div class="contenthead">
					<span>문의내용</span>
				</div>
				<div class="qnatextdiv">
					<textarea class="qnatextarea"></textarea>
				</div>
			</div>
			<div class="qnabtndiv">
				<button class="qnabtn" id="qnabtn">문의 등록하기</button>
			</div>	
		</div>
	</div>
	<!-- 로그인 하라는 알림 모달창 -->
	<div class="loginalertmodal loginalertmodalhidden">
		<div class="alertdiv">
			<div class="alerttextdiv">
				<span>로그인이 필요한 서비스입니다.<br>
				로그인 하시겠습니까?</span>
			</div>
			<div class="alertbtndiv">
				<button class="alertnobtn">아니오</button>
				<button class="alertyesbtn">예</button>
			</div>
		</div>
	</div>
	<!-- 삭제 여부 묻는 모달창 -->
	<div class="deletemodal deletemodalhidden">
		<div class="alertdiv">
			<div class="alerttextdiv">
				<span>정말 삭제하시겠습니까?</span>
			</div>
			<div class="alertbtndiv">
				<button class="deletenobtn">아니오</button>
				<button class="deleteyesbtn">예</button>
			</div>
		</div>
	</div>
<script>

	$(document).ready(()=>{
		let btn=null;
		
		$(document).on("click", ".qnadeletebtn", (e)=>{
			//qna삭제
			//삭제여부를 묻는 모달창을 띄운다.
			$(".deletemodal").removeClass("deletemodalhidden");
			$("html, body").css("overflow", "hidden");
			btn="qna";
		});
		
		$(document).on("click", ".reviewdeletebtn", (e)=>{
			//리뷰삭제
			//삭제여부 모달창을 띄운다.
			$(".deletemodal").removeClass("deletemodalhidden");
			btn="review";
		})
		
		//삭제 모달창에서 '예'를 눌렀을 때
		$(".deleteyesbtn").click(e=>{
			$(".deletemodal").addClass("deletemodalhidden");
			deleteReviewOrQna(btn);
			$("html, body").css("overflow","");
		});
		
		//삭제 모달창에서 '아니오'를 눌렀을 때
		$(".deletenobtn").click(e=>{
			$("html, body").css("overflow", "");
			$(".deletemodal").addClass("deletemodalhidden");
		});
			
	});
	const deleteReviewOrQna=(e)=>{
		if(e=="qna"){
			//qna 삭제일 때
			const qnaKey=$(".qk").val();
			$.ajax({
				url:"<%=request.getContextPath()%>/shoppingmall/deleteqna.do",
				type:"POST",
				data:{"qnaKey":qnaKey},
				success:(response)=>{
					if(response.result!=0){
						//삭제 성공
						location.reload();
						alert("문의글 삭제 성공!");
					}else{
						//삭제 실패
						alert("문의글 삭제 실패!");
					}
				},
				error:()=>{
					alert("오류");
				}
			});
		}else{
			//리뷰 삭제일 때
			//const reviewKey;
		}
	}	
	//qna 수정하기
	$(document).on("click", ".qnaupdatebtn", (e)=>{
		$(".qnamodalContainer").removeClass("qnamodalhidden");
		$("html").css("overflow","hidden");
		$(".qnabtn").addClass("qnamodalupdatebtn").removeClass("qnabtn").text("문의 수정하기");
		const oldQnaText=$(e.target).parent().parent().prev().children().last().text().trim();
		$(".qnatextarea").val(oldQnaText);
		$("#qnabtn").off();
	});
	$(document).on("click", ".qnamodalupdatebtn", (e)=>{
		//문의글 수정하기 ajax
		const qnaKey=$(".qk").val();
		if($(".qnatextarea").val()==""){
			//내용 입력 안했을 때
			alert("내용을 입력해주세요!");
		}else{
			//내용 입력 했을 때
			const content=$(".qnatextarea").val();
			$.ajax({
				url:"<%=request.getContextPath()%>/shoppingmall/updateqna.do",
				type:"POST",
				data:{"qnaKey":qnaKey, "content":content},
				success:(response)=>{
					if(response.result!="0"){
						//문의글 수정 성공
						location.reload();
						alert("문의글 수정 성공!");
					}else{
						alert("문의글 수정 실패!");
					}
				},
				error:()=>{
					alert("에러");
				}
			})
		}
	});
	
	//문의하기 등록버튼 눌러서 등록하기
	$(".qnabtn").click(e=>{
		<%if(loginUser!=null){%>
			//로그인 한 상태
			if($(".qnatextarea").val()==""){
				//내용 입력 안했을 때
				alert("내용을 입력해주세요!");
			}else{
				//내용 입력 했을 때
				const content=$(".qnatextarea").val();
				$.ajax({
					url:"<%=request.getContextPath()%>/shoppingmall/enrollqna.do",
					type:"POST",
					data:{"productKey":<%=p.getProductKey()%>, "userId":"<%=loginUser.getUserId()%>", "content":content},
					success:(response)=>{
						console.log(response.result);
						if(response.result!="0"){
							//문의글 등록 성공
							location.reload();
							alert("문의글 등록 성공!");
						}else{
							alert("문의글 등록 실패!");
						}
					},
					error:()=>{
						alert("에러");
					}
				})
			}
		<%}else{%>
			// 로그인 안한 상태. 로그인 하라고 창 띄우기
			$(".qnamodalContainer").addClass("qnamodalhidden");
			$(".loginalertmodal").removeClass("loginalertmodalhidden");
			$("html").css("overflow","hidden");
		<%}%>
	});
	
	//문의하기 버튼 누를시 문의글등록모달창 띄우기
	$(".enrollQna").click(e=>{
		$(".qnamodalContainer").removeClass("qnamodalhidden");
		$("html").css("overflow","hidden");
	})
	//문의하기 모달창 x 버튼누르면 모달창 닫기
	$(".qnamodalclosebtn").click(e=>{
		$(".qnamodalContainer").addClass("qnamodalhidden");
		$("html").css("overflow","");
	})
	
	//로그인 알림 모달창 '아니오' 버튼 눌렀을 때
	$(".alertnobtn").click(e=>{
		$(".loginalertmodal").addClass("loginalertmodalhidden");
		$("html").css("overflow","");
	})
	//로그인 알림 모달창 '예' 버튼 눌렀을 때
	$(".alertyesbtn").click(e=>{
		$("html").css("overflow","");
		$(".loginalertmodal").addClass("loginalertmodalhidden");
		location.assign("<%=request.getContextPath()%>/user/login.do");
	})
	
	//top 버튼 스크롤 이벤트
	$(".topbtn").click(e=>{
		$("html, body").scrollTop(0);
	});
	
	//qna페이징처리 이벤트
	$(document).on("click", ".qnapagebarnumbtn, .qnapagebarinequalitybtn", e=>{
		const currPage=$(".qnapagebarnum").text().trim(); //현재 선택되어있는 페이지넘버
		console.log(currPage);
		let btnText=$(e.target).text().trim();
		console.log(btnText);
		$.ajax({
			url:"<%=request.getContextPath()%>/shoppingmall/qnapagingajax.do",
			type:"POST",
			data:{"currPage":currPage, "btnText":btnText, "productKey":<%=p.getProductKey()%>},
			success:(response)=>{
				console.log(response);
				const pagebar=response.pagebar;
				$(".qnapagebarContainer").empty().html(pagebar);
				const qnas=response.qna;
				$(".qnaBox").empty();
				$.each(qnas, (i,v)=>{
					const qnaPostBox=$("<div>").addClass("qnaPostBox");
					const qnaTitle=$("<div>").addClass("qnaTitle");
					const qnatag=$("<div>").addClass("qnatag").text("질문");
					const qnaContent=$("<div>").addClass("qnaContent").text(v["qnaContent"]);
					const qnadate=$("<div>").addClass("qnadate");
					const date=$("<span>").text(v["qnaDate"]);
					qnadate.append(date);
					qnaTitle.append(qnatag).append(qnaContent);
					qnaPostBox.append(qnaTitle).append(qnadate);
					$(".qnaBox").append(qnaPostBox);
					if(v["answer"]["qnaAnswerKey"]!=0){
						const answerPostBox=$("<div>").addClass("qnaAnswerBox");
						const answerTitle=$("<div>").addClass("qnaTitle");
						const arrow=$("<div>").addClass("arrow");
						const arrowImg=$("<img>").attr("src","<%=request.getContextPath()%>/images/shoppingmall/down-right-arrow.png");
						const answertag=$("<div>").addClass("answertag").text("답변");
						const answerContent=$("<div>").addClass("qnaContent").text(v["answer"]["qnaAnswerContent"]);
						const answerdate=$("<div>").addClass("qnadate");
						const adate=$("<span>").text(v["answer"]["qnaAnswerDate"]);
						arrow.append(arrowImg);
						answerdate.append(adate);
						answerTitle.append(arrow).append(answertag).append(answerContent);
						answerPostBox.append(answerTitle).append(answerdate);	
						$(".qnaBox").append(answerPostBox);
					}
				});
			}
		});
	});
	
	//리뷰페이징처리 이벤트
	$(document).on('click', '.pagebarnumbtn, .pagebarinequalitybtn, .datesort, .ratingsort', e=>{
		let btnText=$(e.target).text().trim(); //어떤 버튼을 눌렀는지 판단하기위한 버튼text값
		const cPage=$(".pagebarnum").text().trim(); //현재페이지 가져오기
		let sort='최신순'; //기본은 최신순정렬
		if($(e.target).text().trim()=="별점순"){ //별점순 정렬 시
			sort='별점순'; //별점순 정렬
			btnText="1"; //정렬메뉴를 누르면 1페이지가 나오게하기 위함
			$(".datesort").removeClass("selectedReviewSortbtn");
			$(e.target).addClass("selectedReviewSortbtn");
		}else if($(e.target).text().trim()=="최신순"){
			btnText="1"; // 최신순 정렬메뉴를 눌렀을 시 1페이지가 나오게하기 위함
			$(".ratingsort").removeClass("selectedReviewSortbtn");
			$(e.target).addClass("selectedReviewSortbtn");
		}else{
			sort=$(".selectedReviewSortbtn").text().trim(); //정렬버튼이 아닌 버튼들 <<,<,>,>>,숫자버튼
		}
		$.ajax({
			url:"<%=request.getContextPath()%>/shoppingmall/reviewpagingajax.do",
			type:"POST",
			data:{"btnText":btnText, "totalData":<%=p.getTotalReviewCount()%>, "cPage":cPage, "productKey":<%=p.getProductKey()%>, "sort":sort},
			success:(response)=>{
				const pagebar=response.pagebar;
				$(".pagebardiv").empty().html(pagebar);
				const data=response.user;
				$(".reviewContainer").find(".reviewBox").remove();
				$.each(data, (index,v)=>{
					const $reviewBox=$("<div>").addClass("reviewBox");
					const $reviewWriter=$("<div>").addClass("reviewWriter");
					const $reviewWriterImg=$("<div>").addClass("reviewWriterImg");
					const $profileimg=$("<img>");
					$.each(v["dog"], (i,d)=>{
						if("dogImg" in d){
							$profileimg.attr("src","<%=request.getContextPath()%>/upload/user/"+d["dogImg"]);
						}else{
							$profileimg.attr("src","<%=request.getContextPath()%>/images/user.png");
						}
					});
					$reviewWriterImg.append($profileimg);
					$reviewWriter.append($reviewWriterImg);
					const $profile=$("<div>");
					
					const $memberName=$("<span>").addClass("memberName").text(v["userId"]);
					const $reviewDate=$("<span>").addClass("reviewDate").text(v["reviews"][0]["reviewDate"]);
					const $stars=$("<div>").addClass("stars");
					for(let i=0;i<5;i++){
						if(i<v["reviews"][0]["rating"]){
							const $fullstar=$("<div>").addClass("star full-star");
							$stars.append($fullstar);
						}else{
							const $emptystar=$("<div>").addClass("star empty-star");
							$stars.append($emptystar);
						}
					}
					$profile.append($memberName).append($reviewDate).append($stars);
					$reviewWriter.append($profile);
					
					const $reviewImgs=$("<div>").addClass("reviewImgs");
					for(const reviewImgs of v["reviews"][0]["reviewImgs"]){
						if("reviewImg" in reviewImgs){
							const $img=$("<img>").attr("src","<%=request.getContextPath()%>/upload/shoppingmall/review/"+reviewImgs["reviewImg"]);
							$reviewImgs.append($img);
						}
					}
					
					const $reviewContent=$("<div>").addClass("reviewContent");
					const $content=$("<span>").text(v["reviews"][0]["reviewContent"]);
					$reviewContent.append($content);
					$reviewBox.append($reviewWriter).append($reviewImgs).append($reviewContent);
					$(".reviewContainer>div").append($reviewBox);
				})
				
			}
		});
	});

	//모달창 관련
	//모달창 오픈
	$(document).on("click", ".reviewImgs>img", e=>{
		const src=$(e.target).attr("src");
		$(".modalmainimg").attr("src",src);
		const imgs=$(e.target).parent();
		imgs.children().each((i,e)=>{
			const $img=$("<img>").addClass("modalreviewimg").attr("src",$(e).attr("src"));
			if($(e).attr("src")==src){
				$img.addClass("selectedreviewimg");
			}
			$(".modalallimgsdiv").append($img);
		})
		$("html").css("overflow","hidden");
		$(".modalContainer").removeClass("modalhidden");		
	});

	//모달창 닫기
	$(".modalclosebtn").click(e=>{
		$(".modalContainer").addClass("modalhidden");
		$(".modalmainimg").attr("src");
		$(".modalallimgsdiv").html("");
		$("html").css("overflow","");
	});
	//모달창 '>'사진 넘기기
	$(".modalrightbtn").click(e=>{
		const $next=$(".selectedreviewimg").next();
		if($next.length>0){
			$(".selectedreviewimg").removeClass("selectedreviewimg");
			$next.addClass("selectedreviewimg");
			$(".modalmainimg").attr("src",$next.attr("src"));
		}else{
			const $first=$(".selectedreviewimg").parent().children().first();
			$(".selectedreviewimg").removeClass("selectedreviewimg");
			$first.addClass("selectedreviewimg");
			$(".modalmainimg").attr("src",$first.attr("src"));
			
		}
	});
	//모달창 '<'사진 넘기기
	$(".modalleftbtn").click(e=>{
		const $prev=$(".selectedreviewimg").prev();
		console.log($prev);
		if($prev.length>0){
			$(".selectedreviewimg").removeClass("selectedreviewimg");
			$prev.addClass("selectedreviewimg");
			$(".modalmainimg").attr("src",$prev.attr("src"));
		}else{
			const $last=$(".selectedreviewimg").parent().children().last();
			$(".selectedreviewimg").removeClass("selectedreviewimg");
			$last.addClass("selectedreviewimg");
			$(".modalmainimg").attr("src",$last.attr("src"));
		}
	});
	
	//구매페이지 이동 함수
	const movePaypage=()=>{
		location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmallpay.do?productKey=<%=p.getProductKey()%>');
	}
	
	//이미지 누르면 메인이미지 바뀌게하는 함수
	$(".imgbordercontainer").mouseenter(e=>{
		console.log($(e.target));
		const newimg=$(e.target).siblings("img").attr("src");
		$(e.target).parent().parent().find("i").removeClass("selectedimg");
		$(e.target).eq(0).addClass("selectedimg");
		$(e.target).parent().parent().eq(0)
		$(e.target).parent().siblings("img").attr("src",newimg);
	});
	
	//상품개수 마이너스버튼 누를 시 실행되는 함수
	const minus=()=>{
		let count=$("#purchaseQuantity").text();
		if(count>1){
			count=parseInt(count)-1;
			$("#purchaseQuantity").text(count);
			$("#totalPrice").text(count*<%=p.getPrice()*(100-p.getRateDiscount())/100%>);
			$(".stockalarm").text("");
		}
	};
	
	//상품개수 플러스버튼 누를 시 실행되는 함수
	const plus=()=>{
		let count=$("#purchaseQuantity").text();
		count=parseInt(count)+1;
		const size=$("select[name=size]").val();
		const color=$("select[name=color]").val();
		console.log(count+"/"+size+"/"+color);
		$.ajax({
			url:"<%=request.getContextPath()%>/shoppingmall/productoption.do",
    		type:"POST",
    		data:{"productKey":<%=p.getProductKey()%>, "size":size, "color":color},
    		success:(data)=>{
    			console.log(data);
    			let stock=0;
    			if(Array.isArray(data)){
	    			$.each(data,(i,v)=>{
	    				if(v["color"]["color"]==color){
	    					stock=v["stock"];
	    				}
	    			});
    			}else{
    				stock=data["stock"];
    			}
				if(count<=stock){
					$("#purchaseQuantity").text(count);
					$("#totalPrice").text(count*<%=p.getPrice()*(100-p.getRateDiscount())/100%>);
				}else{
					$(".stockalarm").text("재고가 "+stock+"개 남았습니다.");
				}
    		}
		});
	};
	
	$(document).ready(()=>{
		//메뉴 고정 함수
	    const scrollDiv = $('.moveMenuContainer');
	    const fixedOffset = scrollDiv.offset().top; // 고정되기 시작할 스크롤 위치
	
	    $(window).scroll(()=>{
	        let scrollPosition = $(window).scrollTop();
	        
	        if (scrollPosition >= fixedOffset) {
	            scrollDiv.addClass('fixed');
	        } else {
	            scrollDiv.removeClass('fixed');
	        }
	    });
	    //모달창 이벤트 위임
	    //모달창 메인이미지 밑의 작은이미지 클릭시 메인이미지로 바뀌는 이벤트
	    $(".modalallimgsdiv").on("click",".modalreviewimg",e=>{
	    	const src=$(e.target).attr("src");
			console.log(src);
			$(".modalmainimg").attr("src", src);
			$(e.target).parent().children().removeClass("selectedreviewimg");
			$(e.target).addClass("selectedreviewimg");
	    })
	});
	    //옵션 태그 추가
	    <%if(!options.isEmpty()){%>
	    	const $optionDiv=$("<div>").addClass("option").append($("<span>").text("옵션선택 *"));
	    	<%if(!options.stream().anyMatch(e->e.containsKey("NULL"))){%>
	    		const $sizeSelect=$("<select>").attr("name","size").append($("<option>").attr({disabled:true,selected:true}).text("사이즈를 선택해주세요"));
    			<%List<String> key=new ArrayList<>();%>
	    		<%for(Map<String,String> m:options){
	    			for(String k:m.keySet()){
	    				if(!key.contains(k)){
	    					key.add(k);
	    				}
	    			}
	    		}%>
	    		<%for(String e:key){%>	
	    			$sizeSelect.append($("<option>").attr("name","<%=e%>").text("<%=e%>"));
		    		$optionDiv.append($sizeSelect);
	    		<%};%>
	    		<%if(!options.stream().anyMatch(e->e.containsValue("NULL"))){%>
	    			const $colorSelect=$("<select>").attr("name","color").append($("<option>").attr({disabled:true,selected:true}).text("색상을 선택해주세요"));
	    			$optionDiv.append($colorSelect);
	    		<%}%>
	    	<%}else{%>
	    		<%if(!options.stream().anyMatch(e->e.containsValue("NULL"))){%>
    				const $colorSelect=$("<select>").attr("name","color").append($("<option>").attr({disabled:true,selected:true}).text("색상을 선택해주세요"));
    				<%for(Map<String,String> m:options){%>
    					<%for(Map.Entry<String, String> e:m.entrySet()){%>
    						$colorSelect.append($("<option>").attr("name","<%=e.getValue()%>").text("<%=e.getValue()%>"));
    					<%};%>
    				<%}%>
    				$optionDiv.append($colorSelect);
    			<%}%>
    		<%}%>
    		$(".price").after($optionDiv);
	    <%}%>
	    
	    //사이즈 선택시 색상 옵션태그 추가하는 함수
	    $("select[name='size']").change((e)=>{
	    	const size=$(e.target).val();
	    	$("select[name=color]").html("");
	    	$.ajax({
	    		url:"<%=request.getContextPath()%>/shoppingmall/productoption.do",
	    		type:"POST",
	    		data:{"productKey":<%=p.getProductKey()%>, "size":size},
	    		success:(data)=>{
	    			console.log(data);
	    			$.each(data,(i,v)=>{
	    				console.log(v["stock"]+" / "+v["color"]["color"]);
	    				$("select[name=color]").append($("<option>").attr("name",v["color"]["color"]).text(v["color"]["color"]));
	    			});
	    		}
	    	});
	    });
	    
	//옵션 바꿨을때 구매개수 초기화하기
	$(".option>select").change(e=>{
		$(".purchaseQuantity").text("1");
		$(".stockalarm").text("");
		$("#totalPrice").text("<%=p.getPrice()*(100-p.getRateDiscount())/100%>");
	});
	
	
	//리뷰보기를 눌러서 넘어왔을 때 리뷰로 스크롤이동시키는 함수
	$(window).on('load', ()=>{
		<%if(r!=null){%>
			const mmc=$('.reviewContainer').offset().top-$('.moveMenuContainer').outerHeight()*2;
			$('html, body').scrollTop(mmc);
		<%} %>
	});
	//메뉴 스크롤 이동메뉴 함수
	$(document).ready(()=>{
		$('#moveDetail').click((e)=>{
			$('html, body').scrollTop($('.detailImgContainer').offset().top)
		});
		$('#moveReview').click((e)=>{
			$('html, body').scrollTop($('.reviewContainer').offset().top-$('.moveMenuContainer').outerHeight())
		});
		$('#moveQna').click((e)=>{
			$('html, body').scrollTop($('.qnaContainer').offset().top-$('.moveMenuContainer').outerHeight())
		});
		$(".productImgs").eq(0).addClass("selectedImg");
		$(".iborder").eq(0).addClass("selectedimg");
	})

	//펼치기 기능
	$(".folding").click(e=>{
		if($(e.target).text().trim()=='펼치기'){
			$(e.target).text("접기");
			$(".imgborder").removeClass("foldingoption");
		}else{
			$(e.target).text("펼치기");
			$(".imgborder").addClass("foldingoption");
		}
	})

//결제테스트 코드
/* function kakaopay(){
IMP.init("imp74680205");
IMP.request_pay({
    pg : 'kakaopay.TC0ONETIME',
    pay_method : 'card',
    merchant_uid: "order_no_0004", // 상점에서 관리하는 주문 번호 랜덤값 줘야함
    name : '주문명:결제테스트',
    amount : 1,
    buyer_email : 'dpdlxj12@naver.com',
    buyer_name : '구매자이름',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
}, function(rsp) {
    if ( rsp.success ) {
    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
    	jQuery.ajax({
    		url: "/payments/complete", //결제 서블릿으로 넘어가면 될듯.
    		type: 'POST',
    		dataType: 'json',
    		data: {
	    		imp_uid : rsp.imp_uid
	    		//기타 필요한 데이터가 있으면 추가 전달
    		}
    	}).done(function(data) {
    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
    		if ( everythings_fine ) {
    			var msg = '결제가 완료되었습니다.';
    			msg += '\n고유ID : ' + rsp.imp_uid;
    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
    			msg += '\결제 금액 : ' + rsp.paid_amount;
    			msg += '카드 승인번호 : ' + rsp.apply_num;
    			
    			alert(msg);
    		} else {
    			//[3] 아직 제대로 결제가 되지 않았습니다.
    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
    		}
    	});
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        
        alert(msg);
    }
});
}; */
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>