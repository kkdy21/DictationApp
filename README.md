# 프로젝트명
C++ QML 모바일 기반 받아쓰기 비전 AI 프로그램
# 프로젝트기간
2021.10.15. ~ 2021.10.22
# 개발인원
고대연, 유태관, 이근우, 최다엘, 최상문, 최수현, 최진경
# 개발환경
1. Mobile Client
- Linux Ubuntu 20.04 / C++ 9.3.0 / QT 5.15.1 - SDK 31.0.0 / NDK 23.1.7779620 / JDK 12
- Android Studio 2020.03.01 / Android 11
2. Server
- Linux Ubuntu 20.04 / C++ 9.3.0 / Visual Studio Code 1.57.1 / MySQL
3. Ai
- Windows 10 / Python 3.8.8 / PyCharm community 2021.2.2 - Anaconda 4.10.3 / Tensorflow 2.6.0
# 프로그램 소개
- qt,qml로 만든 받아쓰기 어플과 머신비전AI로 작성한 글자를 판별하는 기능을 기반으로 만든 모바일,AI통합 프로그램
# 주요기능
1. Mobile Client
- QMediaplayer클래스를 이용한 받아쓰기 소리 재생
- Canvas,onPaint의 moveTo,lineTo를 이용한 선 그리기, 지우개, 그림 전체삭제기능
- NumberAnimation, gif를 활용한 컨트롤에 효과 부여
- Ai에서 판별한 결과값과 정답 비교
2. Ai
- 손글씨를 Ai에 러닝 시켜 모바일에서 입력한 글자 이미지를 판별하여 문자형으로 반환
# 느낀점
Ai, 모바일(android)에 대해 배울수 있는 과제 였다.   
어떤 일을 하든 첫 단추가 가장 중요하고 어려운것 같다.  
이번 프로젝트 에서도 'qt로 모바일 프로그램을 만들수 있다'는 점은 알았지만 해본적이 없었고 이로 인해 프로그램을 만드는 환경 설정에서 시간이 많이 들었다.   
특히 안드로이는 자바를 기반으로 하기 때문에 jdk를 설치해야 했고 jdk와 gradle버전간 호환성 을 찾고 실험하는데에 고전을 했었다.   
초반부터 한번 지치니까 오히려 더욱 욕심이 났고 기능뿐만 디자인도 찾아봐야 겠다는 생각이 들었다.   
덕분에 javascript를 기반으로 하는 qml을 알게 되었는데 UI애니매이션, 버튼 디자인 등 디자인 에 최적화된 기능이 많아 기존의 qt나 c#의 winform보다 더 괜찮다고 생각이 들었다.   
또한 지금까지 c++, c#으로 된 응용프로그램만 만들었었는데 html css javascript를 기반으로한 웹앱을 만들어 보고싶다는 생각이 많이 들었다. 찾아보니 많은 라이브러리와 많은 자료들, 국내에 많은 개발자들이 있어서 나중에 시간이 되면 이분야로도 진출해보고 싶다는 생각이 들었다.    
하나의 프로젝트를 위해 여러부분을 공부해야 했고 새로운 부분이 많아 어려웠지만 다양한 개발 환경과 경험, 지식을 얻을 수 있는 프로젝트였던것 같다.   
# 프로젝트 소개 ppt
https://1drv.ms/p/s!AvC5FNM5AJNAzTTpvjiQdRKVvLjm?e=6TFUAl
# 시연 영상
https://1drv.ms/v/s!AvC5FNM5AJNAzSZGSUS3rRNsqwFM?e=E6Ozfk
# 주요기능 스크린샷
<img width="761" alt="image" src="https://user-images.githubusercontent.com/86215246/208306749-26748366-9145-4a7f-ad89-81e1d4e33e12.png">
<img width="761" alt="image" src="https://user-images.githubusercontent.com/86215246/208306754-fa622286-6825-44a8-826b-8ddc24b732c3.png">

