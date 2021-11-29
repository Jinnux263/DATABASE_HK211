import React from "react";
import { useEffect, useState, Fragment } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import { ButtonGroup, Button, Table, Row } from "react-bootstrap";
import EditableRow from "../Components/editableRow";
import ReadonlyRow from "../Components/readonlyRow";

const ProfileScreen = () => {
  const params = useParams();

  const [profile, setProfile] = useState({});
  const [First_Name, setFirst_Name] = useState("");
  const [Last_Name, setLast_Name] = useState("");
  const [Phone_Number, setPhone_Number] = useState("");
  const [Birth_Date, setBirth_Date] = useState("");
  const [Sex, setSex] = useState("");
  const [Address, setAddress] = useState("");
  const [Country, setCountry] = useState("");
  const [Email, setEmail] = useState("");
  const [Education, setEducation] = useState("");
  const [showMyCourse, setShowMyCourse] = useState(true);
  const [courses,setCourses] = useState([])
  const [formData, setFormData] = useState({
    First_Name: "",
    Last_Name: "",
    Phone_Number: "",
    Birth_Date: "",
    Sex: "",
    Address: "",
    Country: "",
    Email: "",
    Education: "",
  });

  const handleSubmit = (e) => {
    console.log("Updateing")
    e.preventDefault();
    if (First_Name && Last_Name && Phone_Number &&  Sex && Address && Country &&  Email &&  Education) {
      const item = {
        First_Name: First_Name,
        Last_Name: Last_Name,
        Phone_Number: Phone_Number,
        Birth_Date: Birth_Date,
        Sex: Sex ,
        Address: Address,
        Country: Country,
        Email: Email,
        Education_Degree: Education,
      };
      //console.log(item)
      sendNewProfile(item);
      fetchP();
    }
  };

  const sendNewProfile = (item) => {
    
    axios
      .post(`/api/profile/update/${profile.User_ID}`, item)
      .then((res) => {
        if (res) {
          this.reset();
          alert(res.data);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  }
  const fetchP = async () => {
    const { data } = await axios.get(`/api/profile/${params.userId}`);
    setProfile(data);
  };
  useEffect(() => {
    fetchP();
  }, [params]);

  useEffect(() => {
    const fetchC = async () => {
      const { data } = await axios.get(`/api/myCourses/${params.userId}`);
      //console.log(data)
      setCourses(data);
    };

    fetchC();
  }, [params]);


  return (
    <>
      <ButtonGroup aria-label="Basic example">
        <Button variant="secondary" onClick={() => setShowMyCourse(true)}>
          My Infor
        </Button>
        <Button variant="secondary" onClick={() => setShowMyCourse(false)}>
          Update Infor
        </Button>
      </ButtonGroup>

      {showMyCourse ? (
        <div className="container rounded bg-white mt-5 mb-5">
          <div className="row">
            <div className="col-md-3 border-right">
              <div className="d-flex flex-column align-items-center text-center p-3 py-5">
                <img
                  className="rounded-circle mt-5"
                  width="150px"
                  src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
                  alt="Profile_Picture"
                />
                <span className="font-weight-bold">{profile.Username}</span>
                <span className="text-black-50">UserId: {profile.User_ID}</span>
                <span className="text-black-50">
                  Level: {profile.Education_Degree}
                </span>
              </div>
            </div>
            <div className="col-md-8 border-right">
              <form className="p-3 py-5" onSubmit={(e) => handleSubmit(e)}>
                <div className="d-flex justify-content-between align-items-center mb-3">
                  <h4 className="text-right">User Information</h4>
                </div>
                <div className="row mt-2 py-3">
                  <div className="col-md-6">
                    First name: {profile.First_Name}
                  </div>
                  <div className="col-md-6">Lastname: {profile.Last_Name}</div>
                </div>
                <div className="row mt-3 py-3">
                  <div className="col-md-12 py-3">Gender: {profile.Sex == 'M' ? 'Male' : 'Female'}</div>
                  <div className="col-md-12 py-3">
                    Birthday: {profile.Birth_Date}
                  </div>
                  <div className="col-md-12 py-3">
                    Phone Number: {profile.Phone_Number}
                  </div>
                  <div className="col-md-12 py-3">
                    Address: {profile.Address}
                  </div>
                  <div className="col-md-12 py-3">
                    Country: {profile.Country}
                  </div>
                  <div className="col-md-12 py-3">Email: {profile.Email}</div>
                  <div className="col-md-12 py-3">
                    Education: {profile.Education_Degree}
                  </div>
                </div>
              </form>
            </div>
          </div>

          <div className='row'>
            <Table className="table table-striped table-hover">
              <thead className="table-dark">
                <tr>
                  <th>Course ID</th>
                  <th>Course Name</th>
                  <th>Specialization</th>
                  <th>Level</th>
                  <th>Date Enoll</th>
                </tr>
              </thead>
              <tbody>
                {/* {courses.map((course) => (
                  // <Row key={course.Course_ID}>hi</Row>
                  <Fragment key={course.Course_ID}>
                    {editCourseID === course.id ? (
                      <EditableRow
                        editData={editData}
                      />
                    ) : (
                      <ReadonlyRow
                        course={course}
                      />
                    )}
                  </Fragment>
                ))} */}
              </tbody>
            </Table>
          </div>
        </div>
      ) : (
        <div className="container rounded bg-white mt-5 mb-5">
          <div className="row">
            <div className="col-md-3 border-right">
              <div className="d-flex flex-column align-items-center text-center p-3 py-5">
                <img
                  className="rounded-circle mt-5"
                  width="150px"
                  src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
                  alt="Profile_Picture"
                />
                <span className="font-weight-bold">{profile.Username}</span>
                <span className="text-black-50">UserId: {profile.User_ID}</span>
                <span className="text-black-50">
                  Level: {profile.Education_Degree}
                </span>
              </div>
            </div>
            <div className="col-md-8 border-right">
              <form className="p-3 py-5" onSubmit={(e) => handleSubmit(e)}>
                <div className="d-flex justify-content-between align-items-center mb-3">
                  <h4 className="text-right">Profile Settings</h4>
                </div>
                <div className="row mt-2">
                  <div className="col-md-6">
                    <label className="labels">Name</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="first name"
                      onChange={(e) => setFirst_Name(e.target.value)}
                    />
                  </div>
                  <div className="col-md-6">
                    <label className="labels">Lastname</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="Last name"
                      onChange={(e) => setLast_Name(e.target.value)}
                    />
                  </div>
                </div>
                <div className="row mt-3">
                  <div className="col-md-12">
                    <label className="labels">Gender</label>
                    <select
                      className="form-control"
                      name="city"
                      onChange={(e) => {
                        e.target.value === "1" ? setSex("M") : setSex("L");
                      }}
                    >
                      <option value="0" selected>Select Gender</option>
                      <option value="1">Male</option>
                      <option value="2">Female</option>
                    </select>
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Birthday</label>
                    <input
                      type="date"
                      className="form-control"
                      placeholder="enter birthday"
                      onChange={(e) => setBirth_Date(e.target.value)}
                    />
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Phone Number</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="enter phone number"
                      onChange={(e) => setPhone_Number(e.target.value)}
                    />
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Address</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="enter address"
                      onChange={(e) => setAddress(e.target.value)}
                    />
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Country</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="enter your country"
                      onChange={(e) => setCountry(e.target.value)}
                    />
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Email</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="enter email"
                      onChange={(e) => setEmail(e.target.value)}
                    />
                  </div>
                  <div className="col-md-12">
                    <label className="labels">Education</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="education"
                      onChange={(e) => setEducation(e.target.value)}
                    />
                  </div>
                </div>
                <div className="mt-5 text-center">
                  <button
                    className="btn btn-primary profile-button"
                    type="submit"
                  >
                    Save Profile
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default ProfileScreen;
