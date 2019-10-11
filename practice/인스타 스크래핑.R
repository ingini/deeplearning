library(rvest)
library(dplyr)
library(RSelenium)
install.packages("readxl")
setwd("C:/Users/student/Desktop/Crawl")

# 크롬 열기

remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
url<-'https://www.instagram.com/accounts/login/?source=auth_switcher'
remDr$navigate(url)

# ----------------생략--------------------------
# 아이디 비밀번호 입력               
id <- remDr$findElement(using="css selector", value='._2hvTZ pexuQ zyHYP')
pw <- remDr$findElement(using="xpath", value='//*[@id="f391916ce84978"]') 
id$sendKeysToElement(list("")) 
pw$sendKeysToElement(list("")) 

# 로그인버튼 클릭
btn <- remDr$findElement(using="xpath", value='//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[3]/button') 
btn$clickElement() 
Sys.sleep(1)
# ----------------생략--------------------------

# category 가져오기 (50여개)
cate <- readLines("cate.txt")
cate <- unlist(cate)
cate

hashtag = NULL



# 반복문 시작
for(j in cate){

#검색에 카테고리명 입력

searchbtn <- remDr$findElement(using="css selector", value='#react-root > section > nav > div._8MQSO.Cx7Bp > div > div > div.LWmhU._0aCwM > input') 
searchbtn$sendKeysToElement(list(j)) 
Sys.sleep(3)

# 첫번째 태그 클릭
click <- remDr$findElements(using='xpath','//*[@id="react-root"]/section/nav/div[2]/div/div/div[2]/div[2]/div[2]/div/a[1]/div')
sapply(click,function(x){x$clickElement()})
Sys.sleep(5)

# 첫번째 인기게시물 클릭
click <- remDr$findElements(using='xpath','//*[@id="react-root"]/section/main/article/div[1]/div/div/div[1]/div[1]/a/div[1]/div[2]')
sapply(click,function(x){x$clickElement()})
Sys.sleep(4)

# 해쉬태그 크롤링
doms <- remDr$findElements(using = "css selector", "body > div._2dDPU.vCf6V > div.zZYga > div > article > div.eo2As > div.KlCQn.G14m-.EtaWk > ul > li:nth-child(1) > div > div > div > span > a")
hash_value <- sapply(doms, function (x) {x$getElementText()})
hash_value <- unlist(hash_value)
hashtag <- c(hashtag,hash_value)

# 넘기기 클릭
click <- remDr$findElements(using='xpath','/html/body/div[2]/div[1]/div/div/a')
sapply(click,function(x){x$clickElement()})
Sys.sleep(3)



# 반복문
for(i in 1:300) {

  # 해쉬태그 크롤링
doms <- remDr$findElements(using = "css selector", "body > div._2dDPU.vCf6V > div.zZYga > div > article > div.eo2As > div.KlCQn.G14m-.EtaWk > ul > li:nth-child(1) > div > div > div > span > a")
hash_value <- sapply(doms, function (x) {x$getElementText()})
hash_value <- unlist(hash_value)
hashtag <- c(hashtag,hash_value)

# 넘기기 클릭(2번째부터)
if(length(remDr$findElements(using='xpath','/html/body/div[2]/div[1]/div/div/a[2]'))==0) break;
Sys.sleep(1)


click <- remDr$findElements(using='xpath','/html/body/div[2]/div[1]/div/div/a[2]')
sapply(click,function(x){x$clickElement()})
Sys.sleep(4)

i= i+1    # i 하나씩 늘려주기
} # 1000개씩 해쉬태그 데려오기 반복문 마지막


write.csv(x=hashtag, file = paste(j,".csv"))
hashtag=NULL

# 나가기 클릭
click <- remDr$findElements(using='xpath','/html/body/div[2]/button[1]')
sapply(click,function(x){x$clickElement()})
Sys.sleep(3)

} # 카페 이름 검색어에 돌리기 반복문 마지막

hashtag
