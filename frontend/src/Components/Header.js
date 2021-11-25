import React from 'react'
import { Navbar, Nav, Container } from 'react-bootstrap'
import {LinkContainer} from 'react-router-bootstrap'

const Header = () => {
    return (
        <header>
            <Navbar bg="light" variant='light' expand="lg" collapseOnSelect>
                <Container>
                    <LinkContainer to='/'>
                        <Navbar.Brand>Home page</Navbar.Brand>
                    </LinkContainer>
                    <Navbar.Toggle aria-controls="basic-navbar-nav" />
                    <Navbar.Collapse id="basic-navbar-nav">
                        <Nav className="ms-auto">
                            <LinkContainer to='/login'>
                                <Nav.Link><i className ='fas fa-user'></i> Sign in</Nav.Link>
                            </LinkContainer>
                        </Nav>
                    </Navbar.Collapse>
                </Container>
            </Navbar>
        </header>
    )
}

export default Header
