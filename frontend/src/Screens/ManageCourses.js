import axios from "axios";
import React, { useState, useEffect, Fragment } from "react";
import { Table } from "react-bootstrap";
import { nanoid } from "nanoid";
import EditableRow from "../Components/editableRow";
import ReadonlyRow from "../Components/readonlyRow";

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

    const newFormData = { ...editData };
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

  const handleEditDataSubmit = (event) => {
    event.preventDefault();

    const editedCourse = {
      id: editCourseID,
      Course_ID: editData.Course_ID,
      Course_name: editData.Course_name,
      SPECIALIZATION: editData.SPECIALIZATION,
      Level: editData.Level,
      Description: editData.Description,
      Fee: editData.Fee,
      Admin_ID: editData.Admin_ID,
    };

    const newCourses = [...courses];
    const index = courses.findIndex(
      (course) => course.Course_ID === editData.Course_ID
    );

    newCourses[index] = editedCourse;

    updateCourse(editedCourse);
    setCourse(newCourses);
    setEditCourseID(null);
  };

  const handleEditClick = (event, course) => {
    event.preventDefault();
    setEditCourseID(course.id);

    const courseValues = {
      Course_ID: course.Course_ID,
      Course_name: course.Course_name,
      SPECIALIZATION: course.SPECIALIZATION,
      Level: course.Level,
      Description: course.Description,
      Fee: course.Fee,
      Admin_ID: course.Admin_ID,
    };

    setEditData(courseValues);
  };

  const handleCancelClick = () => {
    setEditCourseID(null);
  };

  const handleDeleteClick = (ID) => {
    const newCourses = [...courses];

    const index = courses.findIndex((course) => course.Course_ID === ID);

    newCourses.splice(index, 1);

    deleteCourse(ID);

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

  const updateCourse = (item) => {
    axios
      .post("/api/courses/update", { item })
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

  const deleteCourse = (ID) => {
    axios
      .post("/api/courses/delete", { ID })
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
      <form onSubmit={handleEditDataSubmit}>
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
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {courses.map((course) => (
              <Fragment>
                {editCourseID === course.id ? (
                  <EditableRow
                    editData={editData}
                    handleEditData={handleEditData}
                    handleCancelClick={handleCancelClick}
                  />
                ) : (
                  <ReadonlyRow
                    course={course}
                    handleEditClick={handleEditClick}
                    handleDeleteClick={handleDeleteClick}
                  />
                )}
              </Fragment>
            ))}
          </tbody>
        </Table>
      </form>

      <h2>Add new course</h2>
      <form onSubmit={handleAddCourseSubmit}>
        <div>
          <label class="form-label">Course ID</label>
          <input
            type="text"
            name="Course_ID"
            class="form-control"
            required="required"
            placeholder="Enter course id"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Course name</label>
          <input
            type="text"
            name="Course_name"
            class="form-control"
            required="required"
            placeholder="Enter course name"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Specialization</label>
          <input
            type="text"
            name="SPECIALIZATION"
            class="form-control"
            required="required"
            placeholder="Enter specialization"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Level</label>
          <input
            type="text"
            name="Level"
            class="form-control"
            required="required"
            placeholder="Enter level"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Description</label>
          <input
            type="text"
            name="Description"
            class="form-control"
            required="required"
            placeholder="Enter description"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Fee</label>
          <input
            type="text"
            name="Fee"
            class="form-control"
            required="required"
            placeholder="Enter fee"
            onChange={handleAddCourse}
          />
        </div>
        <div>
          <label class="form-label">Admin id</label>
          <input
            type="text"
            name="Admin_ID"
            class="form-control"
            required="required"
            placeholder="Enter admin id"
            onChange={handleAddCourse}
          />
        </div>
        <div className="mt-4 text-center">
          <button type="submit" className="btn btn-outline-primary btn-sm">
            Add
          </button>
        </div>
      </form>
    </div>
  );
};

export default ManageCourses;
