import streamlit as st



st.set_page_config(
    page_icon="🏆",
    page_title="핀테크 AI 금융 서비스"
)


st.title("핀테크 AI 금융 서비스")
st.title("")

st.header("☑ 목 차")
text = '''
0️⃣ 사전 프로젝트
1️⃣ Project Ⅰ
2️⃣ Project Ⅱ
3️⃣ Project Ⅲ
'''
st.code(text)
st.header("")
st.header("")
st.header("")


st.subheader("\t0️⃣ 사전 프로젝트")
st.text(": 자기주도형 프로젝트를 진행하기 위한 사전 도입 강의")
text = '''
1. 금융 데이터 활용법\t(Open API / FinanceDataReader ... )
2. 데이터 시각화\t\t(Pandas / Matplotlib / Streamlit ... )
3. 생성 AI 기초\t\t(ChatGPT / Playground / Document  ... )
4. 생성 AI 응용\t\t(ChatGPT API / Langchain / Document ...)
5. 생성 AI 심화\t\t(VectorDB / Custom GPT / Local LLM ...)
'''
st.code(text)
st.subheader("")
st.divider()



# // 서브프로젝트1========================================================
st.subheader("\t1️⃣ Project Ⅰ")
st.subheader("")
st.text(": 종합 금융 지식 교육/상담 GPT 서비스")
text = '''
- 난이도 맞춤형 금융지식 교육 챗봇 (Retrieval GPT)
- 크롤링 등 자체적으로 수집한 데이터 활용 금융/경제 지식 챗봇
- [한국은행 > 경제교육 > 온라인학습 > '어린이/청소년/일반인' ] 금융 콘텐츠
'''
st.code(text)
st.text("> 서비스 구성")
text = '''
- Vector DB
- OpenAIEmbeddings
- OpenAI LLM (gpt-3.5-turbo-16k)
- Langchain

'''
st.code(text)
st.subheader("")
st.divider()
st.subheader("")
# // ====================================================================

# // 서브프로젝트2========================================================
st.subheader("\t2️⃣ Project Ⅱ")
st.subheader("")
st.text(": 금융 데이터(Open API) 연동 종합 서비스")
text = '''
- Open API를 통해 수집한 각 종 금융 데이터 정제 및 분석/시각화/챗봇
- [금리 정보, 환율 정보, 거시 경제 지표, 주식 데이터, 전자공시] 데이터 활용
'''
st.code(text)
st.text("> 서비스 구성")
text = '''
- OpenDart API / FinanceDataReader
- Matplotlib / Pandas
- Quant Algorithm
- Vector DB
- OpenAIEmbeddings
- OpenAI LLM (gpt-3.5-turbo-16k)
- Langchain
'''
st.code(text)
st.subheader("")
st.divider()
st.subheader("")
# // ====================================================================

# // 서브프로젝트3========================================================
st.subheader("\t3️⃣ Project Ⅲ")
st.subheader("")
st.text(": 금융 시나리오 음성봇")
text = '''
- 실시간 고객 응대 서비스
- [음성 분석(STT) > 각종 문서(KMS,상품약관 등..) > 시나리오 챗봇 > 답변 발화(TTS)]
'''
st.code(text)
st.text("> 서비스 구성")
text = '''
- 시나리오
- TTS (Whisper / gtts ...)
'''
st.code(text)
st.subheader("")
st.divider()
st.subheader("")
# // ====================================================================


# .venv\Scripts\activate.bat