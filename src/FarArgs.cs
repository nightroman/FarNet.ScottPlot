namespace ScottPlot;

public class FarArgs
{
    public string? Title { get; set; }
}

public class FarSignalArgs : FarArgs
{
    public string? YLabel { get; set; }
}

public class FarScatterArgs : FarArgs
{
    public FarScatterKind Kind { get; set; }
    public string? XLabel { get; set; }
    public string? YLabel { get; set; }
}

public class FarHistogramArgs : FarArgs
{
    public bool UseProbability { get; set; }
}
