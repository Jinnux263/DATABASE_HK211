import React from 'react'
import { Route, BrowserRouter as Router, Routes} from "react-router-dom";
import Header from './Components/Header';
import Footer from './Components/Footer';
import {Container} from 'react-bootstrap';
import HomeScreen from './Screens/HomeScreen';
import CourseScreen from './Screens/CourseScreen';

function App() {
  return (
    <Router>
      <Header/>
      <main className ='py-3'>
        <Container>
          <Routes >
            <Route exact path='/' element={<HomeScreen/>}/>
            <Route path='/course/:id' element={<CourseScreen/>}/>
          </Routes >
        </Container>
      </main>
      <Footer/>
    </Router>
  );
}

export default App;