import React from 'react'
import { Container, Col, Row } from 'react-bootstrap'

const FormContainer = ({children}) => {
    return (
        <Container>
            <Row className='justify-content-md-center'>
                <Col xs ={12} ms={6} lg ={6} sl ={6}>
                    {children}
                </Col>
            </Row>
        </Container>
    )
}

export default FormContainer