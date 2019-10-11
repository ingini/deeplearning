library(rvest)
library(RSelenium)

# 크롬 열기
remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()

url<-'https://map.naver.com/?query=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C+%ED%85%8C%EB%A7%88%EA%B9%8C%ED%8E%98&type=SITE_1&queryRank=0'
remDr$navigate(url)

df_v = NULL
n_base_v = NULL
n_addr_v = NULL
n_tel_v = NULL
url_v <- NULL


for (i in 6:6) {
  # '지역리스트' 클릭하기
  clickseoul <- remDr$findElements(using='xpath','//*[@id="panel"]/div[2]/div[1]/div[2]/div[1]/div[3]/div[1]/a[1]')
  sapply(clickseoul,function(x){x$clickElement()})
  Sys.sleep(1)
  # 지역구 누르기
  clickgu <- remDr$findElements(using='xpath',paste('//*[@id="panel"]/div[2]/div[1]/div[2]/div[1]/div[3]/div[1]/div[1]/ul/li[',i,']/a',sep=""))
  sapply(clickgu,function(x){x$clickElement()})
  Sys.sleep(1)

    
    #-----------------------------------------------
    repeat{
      # 첫번째페이지 누르기
      #click_first <- remDr$findElements(using='css selector','#panel > div.panel_content.nano.has-scrollbar > div.scroll_pane.content > div.panel_content_flexible > div.search_result > div > div > strong')
      #sapply(click_first,function(x){x$clickElement()})
      #Sys.sleep(1)
      
      # 1페이지 각 상점의 고유 번호 가져오기
      for(list_cafe in 1:10){
        more <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]"))
        if(length(more)==0)break;
        sapply(more,function(x){x$clickElement()})#카페1개클릭
        Sys.sleep(1)
        detail <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]/div[2]/ul/li[4]/a"))
        url <- sapply(detail,function(x){x$getElementAttribute('data-id')})
        url_v <- c(url_v, unlist(url))
      }
      #상호명크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det dt")
      n_base <-sapply(doms2,function(x){x$getElementText()})
      n_base_v <- c(n_base_v, unlist(n_base)) ##상호명까지는 전체 다 돌아간거 확인
      #주소크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det .addr")
      n_addr <-sapply(doms2,function(x){x$getElementText()})
      n_addr_v <- c(n_addr_v, unlist(n_addr))
      
      #전화번호크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det .tel")
      n_tel <-sapply(doms2,function(x){x$getElementText()})
      n_tel_v <- c(n_tel_v, unlist(n_tel))
      
      # 2-4페이지 누르기
      for(page in 3:5){
        clickpage <- remDr$findElements(using='css selector',paste('#panel > div.panel_content.nano.has-scrollbar > div.scroll_pane.content > div.panel_content_flexible > div.search_result > div > div > a:nth-child(',page,')',sep=""))
        if(length(clickpage) == 0){   
          print("브레이크2")
          break};
        sapply(clickpage,function(x){x$clickElement()})
        Sys.sleep(1)
        
        # 2-4페이지 각 상점의 고유 번호 가져오기
        for(list_cafe in 1:10){
          more <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]"))
          if(length(more)==0)break;
          sapply(more,function(x){x$clickElement()})#카페1개클릭
          Sys.sleep(1)
          detail <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]/div[2]/ul/li[4]/a"))
          url <- sapply(detail,function(x){x$getElementAttribute('data-id')})
          url_v <- c(url_v, unlist(url))
        }
        #상호명크롤링
        doms2<-remDr$findElements(using ="css selector",".lsnx_det dt")
        n_base <-sapply(doms2,function(x){x$getElementText()})
        n_base_v <- c(n_base_v, unlist(n_base)) ##상호명까지는 전체 다 돌아간거 확인
        #주소크롤링
        doms2<-remDr$findElements(using ="css selector",".lsnx_det .addr")
        n_addr <-sapply(doms2,function(x){x$getElementText()})
        n_addr_v <- c(n_addr_v, unlist(n_addr))
        
        #전화번호크롤링
        doms2<-remDr$findElements(using ="css selector",".lsnx_det .tel")
        n_tel <-sapply(doms2,function(x){x$getElementText()})
        n_tel_v <- c(n_tel_v, unlist(n_tel))
      }
      
      # 마지막페이지 누르기
      
      click_last <- remDr$findElements(using='css selector','#panel > div.panel_content.nano.has-scrollbar > div.scroll_pane.content > div.panel_content_flexible > div.search_result > div > div > a.last-child')
      if(length(click_last) == 0)   break;
      
      sapply(click_last,function(x){x$clickElement()})
      Sys.sleep(1)
      
      # 5페이지 각 상점의 고유 번호 가져오기
      for(list_cafe in 1:10){
        more <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]"))
        if(length(more)==0)break;
        sapply(more,function(x){x$clickElement()})#카페1개클릭
        Sys.sleep(1)
        detail <- remDr$findElements(using='xpath',paste("//*[@id='panel']/div[2]/div[1]/div[2]/div[2]/ul/li[",list_cafe,"]/div[2]/ul/li[4]/a"))
        url <- sapply(detail,function(x){x$getElementAttribute('data-id')})
        url_v <- c(url_v, unlist(url))
      }
      #상호명크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det dt")
      n_base <-sapply(doms2,function(x){x$getElementText()})
      n_base_v <- c(n_base_v, unlist(n_base)) ##상호명까지는 전체 다 돌아간거 확인
      #주소크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det .addr")
      n_addr <-sapply(doms2,function(x){x$getElementText()})
      n_addr_v <- c(n_addr_v, unlist(n_addr))
      
      #전화번호크롤링
      doms2<-remDr$findElements(using ="css selector",".lsnx_det .tel")
      n_tel <-sapply(doms2,function(x){x$getElementText()})
      n_tel_v <- c(n_tel_v, unlist(n_tel))
      
      
      # 다음페이지 누르기
      clicknext <- remDr$findElements(using='css selector','#panel > div.panel_content.nano.has-scrollbar > div.scroll_pane.content > div.panel_content_flexible > div.search_result > div > div > a.next')
      if(length(clicknext) == 0)   break;
      sapply(clicknext,function(x){x$clickElement()})
      Sys.sleep(1)
    } # repeat문
  
  #다시 서울로 나오기
  click_list <- remDr$findElements(using='xpath','//*[@id="panel"]/div[2]/div[1]/div[2]/div[1]/div[3]/div[1]/a[1]')
  sapply(click_list,function(x){x$clickElement()})
  Sys.sleep(1)
  click_Seoul <- remDr$findElements(using='xpath','//*[@id="panel"]/div[2]/div[1]/div[2]/div[1]/div[3]/div[1]/div[1]/p/a')
  sapply(click_Seoul,function(x){x$clickElement()})
  Sys.sleep(1)
  print("완료")
  
}#각 구마다 for 문

url_v <- gsub("[a-z]", "", url_v)
n_addr_v <- gsub("지번","",n_addr_v)
n_base_v <- gsub("거리뷰","",n_base_v)
n_base_v <- gsub("항공뷰","",n_base_v)
n_base_v <- gsub("가격","",n_base_v)
n_base_v <- gsub("예약","",n_base_v)

#데이터프레임제작
df_v <- data.frame(카페명=n_base_v, 주소=n_addr_v, urllist=url_v)
#엑셀파일제작
write.csv(df_v, "C:/Rstudy/crawling/Donagaemoongu.csv")
