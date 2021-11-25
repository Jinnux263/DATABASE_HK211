import React from 'react'
import { Col, Row, Container } from 'react-bootstrap'

const Footer = () => {
    return (
        <Container>
            <Row>
                <Col className = 'text-center py-3'>
                    Copyright &copy; Assignment2
                </Col>
            </Row>
        </Container>
    )
}

export default Footer
