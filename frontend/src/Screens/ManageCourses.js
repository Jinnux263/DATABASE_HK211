import axios from "axios";
import React, { useState, useEffect } from "react";
import { Table } from "react-bootstrap";
import { nanoid } from "nanoid";
import editableRow from "../Components/editableRow";
import readonlyRow from "../Components/readonlyRow";

const ManageCourses = () => {
  const [courses, setCourse] = useState([]);
  const [addCourse, setAddCourse] = useState({
    Course_ID: "",
    Course_name: "",
    SPECIALIZATION: "",
    Level: "",
    Description: "",
    Fee: 0,
    Admin_ID: "",
  });

  const [editData, setEditData] = useState({
    Course_ID: "",
    Course_name: "",
    SPECIALIZATION: "",
    Level: "",
    Description: "",
    Fee: 0,
    Admin_ID: "",
  });

  const [editCourseID, setEditCourseID] = useState(null);

  const handleAddCourse = (event) => {
    event.preventDefault();

    const fieldName = event.target.getAttribute("name");
    const fieldValue = event.target.value;

    const newFormData = { ...addCourse };
    newFormData[fieldName] = fieldValue;

    setAddCourse(newFormData);
  };

  const handleEditData = (event) => {
    event.preventDefault();

    const fieldName = event.target.getAttribute("name");
    const fieldValue = event.target.value;

    const newFormData = { ...addCourse };
    newFormData[fieldName] = fieldValue;

    setEditData(newFormData);
  };

  const handleAddCourseSubmit = (event) => {
    event.preventDefault();

    const newCourse = {
      id: nanoid(),
      Course_ID: addCourse.Course_ID,
      Course_name: addCourse.Course_name,
      SPECIALIZATION: addCourse.SPECIALIZATION,
      Level: addCourse.Level,
      Description: addCourse.Description,
      Fee: addCourse.Fee,
      Admin_ID: addCourse.Admin_ID,
    };

    const newCourses = [...courses, newCourse];
    insertCourse(newCourse);
    setCourse(newCourses);
  };

  useEffect(() => {
    const fetchCourses = async () => {
      const { data } = await axios.get("api/courses");

      setCourse(data);
    };

    fetchCourses();
  }, []);

  const insertCourse = (item) => {
    axios
      .post("/api/courses/insert", { item })
      .then((res) => {
        if (res) {
          this.reset();
          alert(res.data);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div>
      <Table className="table table-striped table-hover">
        <thead className="table-dark">
          <tr>
            <th>Course ID</th>
            <th>Course Name</th>
            <th>Specialization</th>
            <th>Level</th>
            <th>Description</th>
            <th>Fee</th>
            <th>Admin ID</th>
          </tr>
        </thead>
        <tbody>
          {courses.map((course) => (
            <tr key={course.Course_ID}>
              <td>{course.Course_ID}</td>
              <td>{course.Course_name}</td>
              <td>{course.SPECIALIZATION}</td>
              <td>{course.Level}</td>
              <td>{course.Description}</td>
              <td>{course.Fee}</td>
              <td>{course.Admin_ID}</td>
            </tr>
          ))}
        </tbody>
      </Table>

      <h2>Add new course</h2>
      <form onSubmit={handleAddCourseSubmit}>
        <input
          type="text"
          name="Course_ID"
          required="required"
          placeholder="Enter course id"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="Course_name"
          required="required"
          placeholder="Enter course name"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="SPECIALIZATION"
          required="required"
          placeholder="Enter specialization"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="Level"
          required="required"
          placeholder="Enter level"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="Description"
          required="required"
          placeholder="Enter description"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="Fee"
          required="required"
          placeholder="Enter fee"
          onChange={handleAddCourse}
        />
        <input
          type="text"
          name="Admin_ID"
          required="required"
          placeholder="Enter admin id"
          onChange={handleAddCourse}
        />

        <button
          type="submit"
          className="btn btn-secondary btn-sm"
          //onClick={insertCourse}
        >
          Add
        </button>
      </form>
    </div>
  );
};

export default ManageCourses;
