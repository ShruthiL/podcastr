import React from "react";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() });

import PodcastTile from "./PodcastTile";

describe("PodcastTile", () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(
      <PodcastTile podcast={{ name: "Podcast1", url: "www.podcast.com" }} />
    );
  });

  it("should render an p element", () => {
    expect(wrapper.find("p")).toBeDefined();
  });

  it("should render an p element containing the text via props", () => {
    expect(wrapper.find("p").text()).toBe("Podcast1");
  });
});
