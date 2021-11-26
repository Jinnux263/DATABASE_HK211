import axios from "axios";
import React, { useState, useEffect } from "react";
import { Col, Row } from "react-bootstrap";
import Course from "../Components/Course";

const HomeScreen = () => {
  const [courses, setCourse] = useState([]);

  useEffect(() => {
    const fetchCourses = async () => {
      const { data } = await axios.get("api/courses");
      //   console.log(data[0].Fee);
      setCourse(data);
    };

    fetchCourses();
  }, []);
  return (
    <>
      <h1>Courses List</h1>
      <Row>
        {courses.map((course) => (
          <Col sm={12} md={6} lg={4} sl={3} key={course.Course_ID}>
            <Course course={course} />
          </Col>
        ))}
      </Row>
    </>
  );
};

export default HomeScreen;
