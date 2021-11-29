import React from 'react'
import { useEffect } from 'react';
import { useState } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';

const ProfileScreen = () => {
    const [profile, setProfile] = useState({})
    const params = useParams()
    console.log(profile)
    useEffect(() => {
        const fetchP = async () => {
            const { data } = await axios.get(`/api/profile/${params.userId}`);
            setProfile(data)
        };
    
        fetchP();
    }, [params]);
    return (
        <div className="container rounded bg-white mt-5 mb-5">
            <div className="row">
                <div className="col-md-3 border-right">
                    <div className="d-flex flex-column align-items-center text-center p-3 py-5">
                        <img className="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg" alt="Profile_Picture"/>
                        <span className="font-weight-bold">{profile.Username}</span>
                        <span className="text-black-50">UserId: {profile.User_ID}</span>
                    </div>
                </div>
                <div className="col-md-8 border-right">
                    <div className="p-3 py-5">
                        <div className="d-flex justify-content-between align-items-center mb-3">
                            <h4 className="text-right">Profile Settings</h4>
                        </div>
                        <div className="row mt-2">
                            <div className="col-md-6"><label className="labels">Name</label><input type="text" className="form-control" placeholder="first name" value=""/></div>
                            <div className="col-md-6"><label className="labels">Lastname</label><input type="text" className="form-control" value="" placeholder="Last name"/></div>
                        </div>
                        <div className="row mt-3">
                            <div className="col-md-12"><label className="labels">Gender</label>
                                <select className="form-control" name="city">
                                    <option selected>Select Gender</option>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                </select>
                            </div>
                            <div className="col-md-12"><label className="labels">Birthday</label><input type="date" className="form-control" placeholder="enter birthday" value=""/></div>
                            <div className="col-md-12"><label className="labels">Phone Number</label><input type="text" className="form-control" placeholder="enter phone number" value=""/></div>
                            <div className="col-md-12"><label className="labels">Address</label><input type="text" className="form-control" placeholder="enter address" value=""/></div>
                            <div className="col-md-12"><label className="labels">Country</label><input type="text" className="form-control" placeholder="enter your country" value=""/></div>
                            <div className="col-md-12"><label className="labels">Email</label><input type="text" className="form-control" placeholder="enter email" value=""/></div>
                            <div className="col-md-12"><label className="labels">Education</label><input type="text" className="form-control" placeholder="education" value=""/></div>
                        </div>
                        <div className="mt-5 text-center"><button className="btn btn-primary profile-button" type="button">Save Profile</button></div>
                    </div>
                </div>
                {/* <div className="col-md-4">
                    <div className="p-3 py-5">
                        <div className="col-md-12"><label className="labels">Experience in Designing</label><input type="text" className="form-control" placeholder="experience" value=""/></div> <br/>
                        <div className="col-md-12"><label className="labels">Additional Details</label><input type="text" className="form-control" placeholder="additional details" value=""/></div>
                    </div>
                </div> */}
            </div>
        </div>
    )
}

export default ProfileScreen
