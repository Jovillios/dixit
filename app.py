import streamlit as st
import subprocess

st.set_page_config(page_title="Dixit", page_icon="💬", layout="centered")
st.title("💬 Dixit")

st.write("Search for expression on youtube videos")

# Query input (does *not* auto-trigger search)
query = st.text_input(
    "Search query",
    placeholder="some sentence",
    key="yt_query",
)

channel = st.text_input("Channel filter", placeholder="some channel")

# Search trigger button
search_button = st.button("Search & Load Video", type="primary")

# Divider
st.markdown("---")

# Container for results
results_container = st.container()

if search_button and channel and search_button:
    with st.spinner("Searching YouTube ..."):
        res = (
            subprocess.run(
                ["bash", "quick_search.sh", query, channel],
                capture_output=True,
                text=True,
            )
            .stdout.strip()
            .split("&t=")
        )

        # Embed the video
        if res and len(res) == 2:
            # st.video supports YouTube links directly
            url = res[0]
            start_time = int(res[1])

            results_container.video(url, autoplay=True, start_time=start_time)
        else:
            st.warning("No URL found for the selected result.")
