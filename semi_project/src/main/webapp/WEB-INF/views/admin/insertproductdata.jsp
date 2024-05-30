<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <section class="product-container">
        <div id="product-entry">
        	<div id="product-div">
	            <div class="product-left">
	                <div class="product-group">
	                    <label for="category">상품 카테고리:</label>
	                    <select id="category" name="category">
	                        <option value="1">사료</option>
	                        <option value="2">간식</option>
	                        <option value="3">배변패드</option>
	                        <option value="4">의류</option>
	                        <option value="5">목욕용품</option>
	                        <option value="6">미용기구</option>
	                        <option value="7">하네스/리드줄</option>
	                        <option value="8">기타</option>
	                    </select>
	                </div>
	                <div class="product-group">
	                    <label for="productName">상품 이름:</label>
	                    <input type="text" id="productName" name="productName" required>
	                </div>
	                <div class="product-group">
	                    <label for="price">가격:</label>
	                    <input type="number" id="price" name="price" required>
	                </div>
	                <div class="product-group">
	                    <label for="brand">브랜드:</label>
	                    <input type="text" id="brand" name="brand" required>
	                </div>
	                <div class="product-group">
	                    <label for="discount">할인율:</label>
	                    <input type="number" id="discount" name="discount" required>
	                </div>
	            </div>
	            <div class="product-right">
	                <div class="product-group">
	                    <label for="mainImage">대표사진:</label>
	                    <input type="file" id="mainImage" name="mainImage" accept="image/*" required>
	                </div>
	                <div class="product-group">
	                    <label for="descriptionImage">설명사진:</label>
	                    <input type="file" id="descriptionImage" name="descriptionImage" accept="image/*" multiple required>
	                </div>
	                <div class="product-group">
	                    <label>
	                       색상 옵션 추가 <input type="checkbox" id="colorOption" name="colorOption"> 
	                    </label>
	                </div>
	                <div class="product-group" id="colorGroup" style="display: none;">
	                    <label for="color">색상 옵션:</label>
	                    <select id="color" name="color">
	                        <option value="1">빨강</option>
	                        <option value="2">노랑</option>
	                        <option value="3">초록</option>
	                        <option value="4">검정</option>
	                        <option value="5">파랑</option>
	                    </select>
	                </div>
	                <div class="product-group">
	                    <label>
	                       사이즈 옵션 추가 <input type="checkbox" id="sizeOption" name="sizeOption"> 
	                    </label>
	                </div>
	                <div class="product-group" id="sizeGroup" style="display: none;">
	                    <label for="size">사이즈 옵션:</label>
	                    <select id="size" name="size">
	                        <option value="1">XS</option>
	                        <option value="2">S</option>
	                        <option value="3">M</option>
	                        <option value="4">XL</option>
	                        <option value="5">XXL</option>
	                        <option value="6">XXXL</option>
	                    </select>
	                </div>
	                <div class="product-group">
	                    <label for="stock">상품 입고량:</label>
	                    <input type="number" id="stock" name="stock" required>
	                </div>
                </div>
            </div>
            <button type="submit" id="product-submit">상품 등록</button>
        </div>
    </section>
 