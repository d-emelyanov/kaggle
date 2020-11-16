import plotly.express as px

class Plot:

    def __init__(self):
        self.px = None
        self.data_frame = None

    def plot(self, *args, **kwargs):
        fig = self.px(self.data_frame, *args, **kwargs)
        fig.update_layout(template='simple_white')
        return fig

    def data(self, data):
        self.data_frame = data
        return self

    def __getattr__(self, name):
        self.px = getattr(px,  name)
        return self.plot

