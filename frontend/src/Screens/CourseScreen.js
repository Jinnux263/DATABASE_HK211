import React, {useState, useEffect} from 'react'
import { Col, Image, ListGroup, Row } from 'react-bootstrap'
import { Link, useParams } from 'react-router-dom'
import Rating from '../Components/Rating'
import { useDispatch, useSelector } from 'react-redux';
import { listCourseDetail } from '../actions/courseActions';
import Loader from './../Components/Loader';
import Message from './../Components/Message';


const CourseScreen = (props) => {
    const dispatch = useDispatch();
    const courseDetail = useSelector((state) => state.courseDetail);
    const { loading, error, course } = courseDetail;

    const params = useParams();
    //console.log(params)
    useEffect(() => {
        dispatch(listCourseDetail(params.id))
    }, [dispatch, params])

    return (
        <>
            <Link to="/" className='btn btn-dark my-3'>Go back</Link>
            {loading ? (
            <Loader/>
            ) : error ? (
                <Message variant='danger'>{error}</Message>
            ) : (
                <Row>
                    <Col md = {6}>
                        <Image src = ""/>
                    </Col>
                    <Col md = {3}>
                        <ListGroup>
                            <ListGroup.Item>
                                <h2>{course.Course_name}</h2>
                            </ListGroup.Item>
                            <ListGroup.Item>
                                <Rating value={4.5} text = 'test'/>
                            </ListGroup.Item>
                        </ListGroup>
                    </Col>
                </Row>
            )}
            
        </>
    )
}

export default CourseScreen
