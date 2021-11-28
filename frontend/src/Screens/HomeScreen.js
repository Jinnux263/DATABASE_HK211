import React, { useEffect } from "react";
import { Col, Row } from "react-bootstrap";
import Course from "../Components/Course";
import Message from './../Components/Message';
import Loader from "../Components/Loader";
import { useDispatch, useSelector } from "react-redux";
import { listCourses } from "./../actions/courseActions";

const HomeScreen = () => {
  const dispatch = useDispatch();

  const courseList = useSelector((state) => state.courseList);
  const { loading, error, courses } = courseList;

  useEffect(() => {
    //console.log("Client fetching...")
    dispatch(listCourses());
  }, [dispatch]);

  return (
    <>
      <h1>Courses List</h1>
      {loading ? (
        <Loader/>
      ) : error ? (
        <Message variant='danger'>{error}</Message>
      ) : (
        <Row>
          {courses.map((course) => (
            <Col sm={12} md={6} lg={4} sl={3} key={course.Course_ID}>
              <Course course={course} />
            </Col>
          ))}
        </Row>
      )}
    </>
  );
};

export default HomeScreen;
