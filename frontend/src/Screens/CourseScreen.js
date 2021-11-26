import axios from 'axios';
import React, {useState, useEffect} from 'react'
import { Col, Image, ListGroup, Row } from 'react-bootstrap'
import { Link, useParams } from 'react-router-dom'
import Rating from '../Components/Rating'


const CourseScreen = (props) => {
    const params = useParams();
    const [course, setCourse] = useState({})
    
    useEffect(() => {
        const fetchCourse = async () => {
            const {data} = await axios.get(`/api/course/${params.id}`)
            //console.log(data[0])
            setCourse(data[0])
        }

        fetchCourse()
    }, [params.id])

    return (
        <>
            <Link to="/" className='btn btn-dark my-3'>Go back</Link>
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
        </>
    )
}

export default CourseScreen
