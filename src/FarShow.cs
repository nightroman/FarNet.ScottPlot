namespace ScottPlot;

/// <summary>
/// Shows plots.
/// </summary>
public static class FarShow
{
    /// <summary>
    /// Shows Histogram.
    /// </summary>
    public static void Histogram(double[] ys, FarHistogramArgs? args = null)
    {
        const int N = 20;
        var min = ys.Min();
        var max = ys.Max();

        var plot = new FarPlot(args?.Title);
        plot.YLabel("Count");

        var hist = Statistics.Histogram.WithBinCount(N, ys);

        var set1 = plot.Add.Bars(hist.Bins, hist.Counts);
        foreach (var b in set1.Bars)
            b.Size = hist.FirstBinSize * 0.8;

        if (args is { })
        {
            if (args.UseProbability)
            {
                plot.Axes.Right.Label.Text = "Probability";

                var pd = new Statistics.ProbabilityDensity(ys);
	            var xs2 = Generate.RangeWithCount(min, max, N * 2);
                var ys2 = pd.GetYs(xs2, 1);

                var set2 = plot.Add.ScatterLine(xs2, ys2);
                set2.Axes.YAxis = plot.Axes.Right;
                set2.LineWidth = 2;
                set2.LineColor = Colors.Black;
                set2.LinePattern = LinePattern.DenselyDashed;
            }
        }

        plot.Show();
    }

    /// <summary>
    /// Shows Scatter.
    /// </summary>
    public static void Scatter(double[] xs, double[] ys, FarScatterArgs? args = null)
    {
        var plot = new FarPlot(args?.Title!);

        if (args is null)
        {
            plot.Add.Scatter(xs, ys);
        }
        else
        {
            switch (args.Kind)
            {
                case FarScatterKind.Line:
                    plot.Add.ScatterLine(xs, ys);
                    break;
                case FarScatterKind.Points:
                    plot.Add.ScatterPoints(xs, ys);
                    break;
                default:
                    break;
            }

            if (args.XLabel is { } x)
                plot.XLabel(x);

            if (args.YLabel is { } y)
                plot.YLabel(y);
        }

        plot.Show();
    }

    /// <summary>
    /// Shows Signal.
    /// </summary>
    public static void Signal(double[] ys, FarSignalArgs? args = null)
    {
        var plot = new FarPlot(args?.Title);
        plot.Add.Signal(ys);

        if (args is { })
        {
            if (args.YLabel is { } label)
                plot.YLabel(label);
        }

        plot.Show();
    }
}
