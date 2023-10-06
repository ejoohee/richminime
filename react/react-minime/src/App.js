import "./App.css";
import { Carousel } from "react-responsive-carousel";
import imageData from "./imageData.js";
import { useState } from "react";
import "react-responsive-carousel/lib/styles/carousel.min.css";
function App() {
  const renderSlides = imageData.map((image) => (
    <div key={image.alt}>
      <img src={image.url} alt={image.alt} className="slice-img" />
    </div>
  ));
  const [currentIndex, setCurrentIndex] = useState();
  function handleChange(index) {
    setCurrentIndex(index);
  }

  return (
    <div className="app-card">
      <div className="app-card-images">
        <img
          src="https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/24%EC%A7%B1%EA%B5%AC%EC%97%AC%EC%B9%9C%EC%88%98%EC%A7%80_%EC%B0%A9%EC%9A%A9.png"
          alt="Minecraft Gameplay"
        />
      </div>
      <div className="app-card-info">
        <div className="app-card-center">
          <img
            src="https://richminime.s3.ap-northeast-2.amazonaws.com/slide/%EB%A1%9C%EA%B3%A0.png"
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
          <button className="download-button" onClick={() => window.location.href="https://richminime.s3.ap-northeast-2.amazonaws.com/slide/richminime.zip"}>다운로드</button>
        </div>
        <div className="footer">
          <div className="footer-1">
            <h2>RichMinime 스크린샷</h2>
            <Carousel
              showArrows={true}
              autoPlay={true}
              infiniteLoop={true}
              showThumbs={false}
              selectedItem={imageData[currentIndex]}
              onChange={handleChange}
              className="slide-component"
              showStatus={false}
            >
              {renderSlides}
            </Carousel>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
