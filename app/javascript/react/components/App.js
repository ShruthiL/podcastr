import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import PodcastsIndexContainer from "../containers/PodcastsIndexContainer";
import PodcastsNewContainer from "../containers/PodcastsNewContainer";
import PodcastShowContainer from "../containers/PodcastShowContainer";

export const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={PodcastsIndexContainer} />
          <Route exact path="/podcasts" component={PodcastsIndexContainer} />
          <Route exact path="/podcasts/new" component={PodcastsNewContainer} />
          <Route exact path="/podcasts/:id" component={PodcastShowContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  );
};

export default App;
