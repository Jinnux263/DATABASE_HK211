import Header from './Component/Header';
import Footer from './Component/Footer';
import {Container} from 'react-bootstrap';

function App() {
  return (
    <>
      <Header/>
      <main className ='py-3'>
        <Container>
          <h1>React here!</h1>
        </Container>
      </main>
      <Footer/>
    </>
  );
}

export default App;
