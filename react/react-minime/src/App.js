import "./App.css";

function App() {
  return (
    <div className="app-card">
      <div className="app-card-images">
        <img
          src="https://i.namu.wiki/i/7tIRMoXytpcOXBK3Z3lCCAxwGTr98717aahDImkLgruFRfac9--zRtJjdEouiuk5fyi-lgdr9u34y9tOgLN5NUhtoGi0gR0i2FEi3nwaqSujd2jxhZQPKD7DXkliGU46fUWzbj01SSyEbwa3Ky0Ltg.webp"
          alt="Minecraft Gameplay"
        />
      </div>
      <div className="app-card-info">
        <div className="app-card-center">
          <img
            src="https://d2k6w3n3qf94c4.cloudfront.net/media/test/main_image/95CA34DA-9280-4CCD-980E-34CCDFE9EC18.jpeg"
            alt="Minecraft Logo"
            className="app-logo"
          />
          <div className="black"></div>
          <div className="app-card-right">
            <h1 className="name">RichMinime</h1>
            <p className="team">SSAFY-A704</p>
            <p className="free">무료</p>
          </div>
        </div>
        <div className="app-card-bottom">
          <div className="app-rating">
            <div className="app-rating-1">5.0★</div>
            <div className="app-rating-2">리뷰 500 +</div>
          </div>
          <hr className="vertical-line"></hr>
          <div className="app-downloads">
            <div className="app-downloads-1">500+</div>
            <div className="app-downloads-2">다운로드</div>
          </div>
          <hr className="vertical-line"></hr>
          <div className="app-available">
            <img
              className="app-available-img"
              src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/GRAC_All_%28%EC%A0%84%EC%B2%B4%EC%9D%B4%EC%9A%A9%EA%B0%80%29.svg/768px-GRAC_All_%28%EC%A0%84%EC%B2%B4%EC%9D%B4%EC%9A%A9%EA%B0%80%29.svg.png"
            ></img>
            <div className="app-available-1">전체이용가</div>
          </div>
        </div>
        <div className="download">
          <button className="download-button">다운로드</button>
        </div>
      </div>
      <div className="footer"></div>
    </div>
  );
}

export default App;
