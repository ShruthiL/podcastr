import React from "react";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
import { BrowserRouter,Link } from "react-router-dom";

Enzyme.configure({ adapter: new Adapter() });

import PodcastTile from "./PodcastTile";

describe("PodcastTile", () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(
      <BrowserRouter>
        <PodcastTile podcast={{ name: "Podcast1", url: "www.podcast.com", id: 1 }} />
      </BrowserRouter>
    );
  });

  it("should render an a element", () => {
    expect(wrapper.find("Link")).toBeDefined();
  });

  it("should render an a element containing the text via props", () => {
    expect(wrapper.find("Link").props()["to"]).toBe("/podcasts/1");
  });
});
