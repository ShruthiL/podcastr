import React, { useState, useEffect } from "react";
import { Redirect } from 'react-router-dom';
import _ from "lodash"

import ErrorList from '../components/ErrorList.js'

const PodcastsNewContainer = (props) => {
    const fields = ["name", "url"]
    const [podcastRecord, setPodcastRecord] = useState({
        name: "",
        url: "",
    })
    const [newRecord, setNewRecord] = useState({})
    const [shouldRedirect, setShouldRedirect] = useState(false)
    const [errors, setErrors] = useState({})

    const handleChange = (event) => {
        setPodcastRecord({
            ...podcastRecord,
            [event.currentTarget.id]: event.currentTarget.value
        })
    }

    const validForSubmission = () => {
        let submitErrors = {}
    
        for (const field in fields) {
          if (podcastRecord[field].trim() === "") {
            submitErrors = {
              ...submitErrors,
              [field]: `${field} is blank`
            }
          }
        }
    
        setErrors(submitErrors)
        return _.isEmpty(submitErrors)
      }

    const onSubmit = (event) => {
        event.preventDefault()

        if (validForSubmission()) {
            let formPayload = {
                podcast: podcastRecord
            }
            fetch("/api/v1/podcasts", {
                credentials: "same-origin",
                method: "POST",
                body: JSON.stringify(formPayload),
                headers: {
                    Accept: "application/json",
                    "Content-Type": "application/json"
                }
            })
            .then(response => {
                if (response.ok) {
                    return response
                } else {
                    let errorMessage = `${response.status} (${response.statusText})`
                    let error = new Error(errorMessage)
                    throw error
                }
            })
            .then(response => response.json())
            .then(body => {
                let newPodcast = body.podcast
                setNewRecord(newPodcast)
                setShouldRedirect(true)
            })
            .catch(error => console.error(`Error in fetch: ${error.message}`))
        }
    }

    if (shouldRedirect) {
        return <Redirect to='/podcasts' />
        // <Redirect to=`/podcast/${newRecord.id}`/>
    }

    return (
        <div>
            <ErrorList errors={errors}/>
            <form className="new-podcast" onSubmit={onSubmit}>
                <label>
                    Name:
                        <input
                            type="text"
                            id="name"
                            onChange={handleChange}
                            value={podcastRecord.name}
                        />
                </label>

                <label>
                    URL:
                        <input
                            type="text"
                            id="url"
                            onChange={handleChange}
                            value={podcastRecord.url}
                        />
                </label>

                <input className="button" type="submit" value="Submit" />
            </form >
        </div>
    )
}
export default PodcastsNewContainer