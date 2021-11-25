import React from 'react'
import { Col, Image, ListGroup, Row } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import Rating from '../Components/Rating'


const CourseScreen = () => {
    return (
        <>
            <Link className='btn btn-dark my-3'>Go back</Link>
            <Row>
                <Col md = {6}>
                    <Image src = ""/>
                </Col>
                <Col md = {3}>
                    <ListGroup>
                        <ListGroup.Item>
                            <h2>Name</h2>
                        </ListGroup.Item>
                        <ListGroup.Item>
                            <Rating value={1} text = 'test'/>
                        </ListGroup.Item>
                    </ListGroup>
                </Col>
            </Row>
        </>
    )
}

export default CourseScreen
